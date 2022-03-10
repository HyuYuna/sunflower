package site.unp.cms.domain;

import java.util.Date;

import site.unp.core.domain.UsersVO;

public class MemberVO extends UsersVO {
    private static final long serialVersionUID = -8000593049986438363L;


    /**
     * 사용자타입코드
     */
    private String userTyCd = "";

    /**
     * 사용자이메일주소
     */
    private String userEmad = "";

    /**
     * 사용자휴대전화번호
     */
    private String userCpno = "";

    /**
     * 인증구분코드
     */
    private String crtfcSeCd = "";

    /**
     * 미성년자인증여부(14세미만: 'Y')
     */
    private String chldCrtfcAt = "";

    /**
     * 생년월일
     */
    private String brthdy = "";

    /**
     * 성별코드
     */
    private String sexCd = "";

    /**
     * 로그인일시
     */
    private Date lastLoginDt = null;

    /**
     * 비밀번호변경일시
     */
    private Date passwordChangeDt = null;

    /**
     * 약관동의일시
     */
    private Date stplatAgreDt = null;

    /**
     * 부서명
     */
    private String deptNm = "";
    
    private String centerName = "";
    private String centerName2 = "";
    private String centerName3 = "";

    /**
     * 회원가입 인증 타입
     */
    private String GlobalsSiteSe = "";
    
    

    public String getCenterName() {
		return centerName;
	}

	public void setCenterName(String centerName) {
		this.centerName = centerName;
	}

	public String getUserTyCd() {
        return userTyCd;
    }

    public void setUserTyCd(String userTyCd) {
        this.userTyCd = userTyCd;
    }

    public String getUserEmad() {
        return userEmad;
    }

    public void setUserEmad(String userEmad) {
        this.userEmad = userEmad;
    }

    public String getUserCpno() {
        return userCpno;
    }

    public void setUserCpno(String userCpno) {
        this.userCpno = userCpno;
    }

    public String getCrtfcSeCd() {
        return crtfcSeCd;
    }

    public void setCrtfcSeCd(String crtfcSeCd) {
        this.crtfcSeCd = crtfcSeCd;
    }

    public String getChldCrtfcAt() {
        return chldCrtfcAt;
    }

    public void setChldCrtfcAt(String chldCrtfcAt) {
        this.chldCrtfcAt = chldCrtfcAt;
    }

    public String getBrthdy() {
        return brthdy;
    }

    public void setBrthdy(String brthdy) {
        this.brthdy = brthdy;
    }

    public String getSexCd() {
        return sexCd;
    }

    public void setSexCd(String sexCd) {
        this.sexCd = sexCd;
    }

    public Date getLastLoginDt() {
        return lastLoginDt;
    }

    public void setLastLoginDt(Date lastLoginDt) {
        this.lastLoginDt = lastLoginDt;
    }

    public Date getPasswordChangeDt() {
        return passwordChangeDt;
    }

    public void setPasswordChangeDt(Date passwordChangeDt) {
        this.passwordChangeDt = passwordChangeDt;
    }

    public Date getStplatAgreDt() {
        return stplatAgreDt;
    }

    public void setStplatAgreDt(Date stplatAgreDt) {
        this.stplatAgreDt = stplatAgreDt;
    }

    public String getDeptNm() {
        return deptNm;
    }

    public void setDeptNm(String deptNm) {
        this.deptNm = deptNm;
    }

    public String getGlobalsSiteSe() {
        return GlobalsSiteSe;
    }

    public void setGlobalsSiteSe(String globalsSiteSe) {
        GlobalsSiteSe = globalsSiteSe;
    }
    private String userId           = ""; 
    private String userPassword     = "";
    private String userName         = "";
    private String centerCode       = "";
    private String centerCode2       = "";
    private String centerCode3       = "";
    private String userState        = "";
    private String userPhone        = "";
    private String userSex          = "";
    private String userLevel        = "";
    private Date   userCdate        = null;
    
    /*입사날짜*/
    private String userBdate        = "";
    /*퇴사날*/
    private String userEdate        = "";
    private String userBirth        = "";
    private String userGroup        = "";
    private String userDepartment   = "";
    private String userPosition     = "";
    private String userEmail        = "";
    private String userNumber       = "";
    private Date   userPdate        = null;
    
    public String getUserId() {
        return userId;
    }
    public String getUserPassword() {
        return userPassword;
    }
    public String getUserName() {
        return userName;
    }
    public String getCenterCode() {
        return centerCode;
    }
    public String getUserState() {
        return userState;
    }
    public String getUserPhone() {
        return userPhone;
    }
    public String getUserSex() {
        return userSex;
    }
    public String getUserLevel() {
        return userLevel;
    }
    public Date getUserCdate() {
        return userCdate;
    }
    public String getUserBdate() {
        return userBdate;
    }
    public String getUserEdate() {
        return userEdate;
    }
    public String getUserBirth() {
        return userBirth;
    }
    public String getUserGroup() {
        return userGroup;
    }
    public String getUserDepartment() {
        return userDepartment;
    }
    public String getUserPosition() {
        return userPosition;
    }
    public String getUserEmail() {
        return userEmail;
    }
    public String getUserNumber() {
        return userNumber;
    }
    public Date getUserPdate() {
        return userPdate;
    }

    
    public void setUserId(String userId) {
        this.userId = userId;
    }
    public void setUserPassword(String userPassword) {
        this.userPassword = userPassword;
    }
    public void setUserName(String userName) {
        this.userName = userName;
    }
    public void setCenterCode(String centerCode) {
        this.centerCode = centerCode;
    }
    public void setUserState(String userState) {
        this.userState = userState;
    }
    public void setUserPhone(String userPhone) {
        this.userPhone = userPhone;
    }
    public void setUserSex(String userSex) {
        this.userSex = userSex;
    }
    public void setUserLevel(String userLevel) {
        this.userLevel = userLevel;
    }
    public void setUserCdate(Date userCdate) {
        this.userCdate = userCdate;
    }
    public void setUserBdate(String userBdate) {
        this.userBdate = userBdate;
    }
    public void setUserEdate(String userEdate) {
        this.userEdate = userEdate;
    }
    public void setUserBirth(String userBirth) {
        this.userBirth = userBirth;
    }
    public void setUserGroup(String userGroup) {
        this.userGroup = userGroup;
    }
    public void setUserDepartment(String userDepartment) {
        this.userDepartment = userDepartment;
    }
    public void setUserPosition(String userPosition) {
        this.userPosition = userPosition;
    }
    public void setUserEmail(String userEmail) {
        this.userEmail = userEmail;
    }
    public void setUserNumber(String userNumber) {
        this.userNumber = userNumber;
    }
    public void setUserPdate(Date userPdate) {
        this.userPdate = userPdate;
    }

	public String getCenterCode2() {
		return centerCode2;
	}

	public void setCenterCode2(String centerCode2) {
		this.centerCode2 = centerCode2;
	}

	public String getCenterCode3() {
		return centerCode3;
	}

	public void setCenterCode3(String centerCode3) {
		this.centerCode3 = centerCode3;
	}

	public String getCenterName2() {
		return centerName2;
	}

	public void setCenterName2(String centerName2) {
		this.centerName2 = centerName2;
	}

	public String getCenterName3() {
		return centerName3;
	}

	public void setCenterName3(String centerName3) {
		this.centerName3 = centerName3;
	}
    
    

}
