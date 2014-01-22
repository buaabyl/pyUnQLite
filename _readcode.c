unqlite_jx9.c:516:static int unqliteBuiltin_db_total_records(...)
    //this interface can get the total records of db.
    //but just for jx9! and fellow codes get result.
	unqlite_vm* pVm = (unqlite_vm *)jx9_context_user_data(pCtx);
	/* Fetch the collection */
	unqlite_col* pCol = unqliteCollectionFetch(pVm,&sName,UNQLITE_VM_AUTO_LOAD);
	if( pCol ){
		unqlite_int64 nRec;
		nRec = unqliteCollectionTotalRecords(pCol);

unqlite_jx9.c:936:int unqliteRegisterJx9Functions(...)
    //this interface register unqlite_vm* vm as userdata to jx9 vm.
    //and call jx9_create_function register db interface.

jx9_api.c:800:int jx9_create_function(...)
    //register user c interface to jx9 vm.

---
//so we just look around as unqlite api.
//unqlite_vm is create by unqlite_compile
api.c:911:int unqlite_compile(...)

