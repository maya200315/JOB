class AppApi {
  static String url = "http://127.0.0.1:8000/api";
  static String urlimage = "http://127.0.0.1:8000/Storage/";

  //Auth
  static String LOGIN = '/login';
  static String REGISTER = '/register';

  //For All Role
  static String GetAllSpecializations = '/specializations';
  static String GetAllSkills = '/skills';

  //Admin Api's
  static String GetAllCompanyPending = '/pending-employers';
  static String AddSpecialization = '/specializations';
  static String DeleteSpecialization(int id) => '/specializations/$id';
  static String AddSkill = '/skills';
  static String DeleteSkill(int id) => '/skills/$id';
  static String ApproveCompany(int id) => '/approve-employer/$id';
  static String RejectCompany(int id) => '/reject-employer/$id';

  //Employers Api's
  static String GetAllMyJobs = '/my-jobs';
  static String AddJob = '/jobs';
  static String UpdateJob(int id) => '/jobs/$id';
  static String DeleteJob(int id) => '/jobs/$id';
  static String GetAllMyApplicants(int id) => '/jobs/$id/applicants';
  static String ApproveApplication(int id) =>
      '/applications/$id/respond/accepted';
  static String RejectApplication(int id) =>
      '/applications/$id/respond/rejected';

  //Job_Seeker Api's
  static String GetAllOpportunities = '/opportunities';
  static String ApplyJob(int id) => '/jobs/$id/apply';
  static String WithdrawJob(int id) => '/jobs/$id/withdraw';
  static String GetAllMyApplications = '/my-applications';
}
