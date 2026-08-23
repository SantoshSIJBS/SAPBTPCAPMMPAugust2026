module.exports = cds.service.impl(async function () {
    // We need to use generic handlers to design your custom business logic
    //      1. this.before()    : This generic handler is used to perform the pre-validations / pre-check.
    //      2. this.on()        : This generic handler is used to perform database operations.
    //      3. this.after()     : This generic handler is used to perform post database operation activities.

    // Step-1 : Get the object from ODATA entities
    let { EmployeeSrv, POSrv } = this.entities;
    const { uuid } = cds.utils;

    // Step-2 : Define this.before() generic handler for the pre-validations / pre-checks
    this.before('UPDATE', EmployeeSrv, (request, response) => {
        console.log("Salary of the employee: ", request.data.salaryAmount);

        if (parseFloat(request.data.salaryAmount) >= 100000) {
            request.error(500, "Please get the approval from your line manager.")
        }
    })

    this.on('getHighestSalariesEmp', async (request, response) => {
        try {
            // Step-1 : Createa a transaction object
            const transaction = cds.tx(request);

            // Step-2: Get salaries of employees
            const response = await transaction.read(EmployeeSrv).orderBy({
                salaryAmount: 'desc'
            }).limit(5);

            // Step-3 : Display the employee salaries
            return response;
        } catch (error) {
            return "Error: " + error.toString();
        }
    })

    this.on('createEmployee', async (request, response) => {


            // Step-1 : Get the input data from your service
            const dataset = request.data;

            // Step-2 : Generate new UUID
            let id = uuid();

            // Step-3 : Create a transaction object
            const transaction = cds.tx(request);

            // Step-4 : Insert a record into Employee service using cds.tx().run
            let returndata = await transaction.run([
                INSERT.into(EmployeeSrv).entries(dataset)
            ]).then((resolve, reject)=>{
                if (typeof (resolve) !== undefined) {
                    return request.data;
                } else {
                    request.error(500, "Error in creating the employee details.")
                }
            }).catch(err =>{
                request.error(500, "There is an error: ", err.toString());
            });

            // Step-5 : Return the response
            return returndata;
    })

    // Implementing instance bounded action
    this.on('discountPrice', async(request, response)=>{
        try {
            const ID = request.params[0];

            const transaction = cds.tx(request);

            await transaction.update(POSrv).with({
                GROSS_AMOUNT : {
                    '-=' : 1000
                },
                NET_AMOUNT : {
                    '-=' : 800
                },
                TAX_AMOUNT : {
                    '-=' : 200
                }
            }).where(ID)
        } catch (error) {
            return "Error : " + error.toString();
        }
    })
})