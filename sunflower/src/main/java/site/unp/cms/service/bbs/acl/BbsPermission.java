package site.unp.cms.service.bbs.acl;

import org.springframework.security.acls.domain.AbstractPermission;

@SuppressWarnings("serial")
public class BbsPermission extends AbstractPermission {

    public static final BbsPermission READ = new BbsPermission(1 << 0, 'R'); // 1
    public static final BbsPermission WRITE = new BbsPermission(1 << 1, 'W'); // 2
    public static final BbsPermission CREATE = new BbsPermission(1 << 2, 'C'); // 4
    public static final BbsPermission DELETE = new BbsPermission(1 << 3, 'D'); // 8
    public static final BbsPermission ANSWER = new BbsPermission(1 << 4, 'A'); // 16
	public static final BbsPermission LIST = new BbsPermission(1 << 5, 'L'); //32
	public static final BbsPermission FILE_UPLOAD = new BbsPermission(1 << 6, 'X'); //64
	public static final BbsPermission FILE_DOWNLOAD = new BbsPermission(1 << 7, 'Z'); //64
	public static final BbsPermission GONGJI = new BbsPermission(1 << 8, 'G'); //64
	public static final BbsPermission UPDATE = new BbsPermission(1 << 9, 'U'); //64

	public BbsPermission(int mask, char c) {
		super(mask, c);
	}

	public char getCode() {
		return this.code;
	}

	public static BbsPermission getBbsPermission(String p) {
		BbsPermission result = BbsPermission.READ;
		if (p.equals("W")) {
			result = BbsPermission.WRITE;
		}
		else if (p.equals("C")) {
			result = BbsPermission.CREATE;
		}
		else if (p.equals("D")) {
			result = BbsPermission.DELETE;
		}
		else if (p.equals("A")) {
			result = BbsPermission.ANSWER;
		}
		else if (p.equals("L")) {
			result = BbsPermission.LIST;
		}
		else if (p.equals("X")) {
			result = BbsPermission.FILE_UPLOAD;
		}
		else if (p.equals("Z")) {
			result = BbsPermission.FILE_DOWNLOAD;
		}
		else if (p.equals("G")) {
			result = BbsPermission.GONGJI;
		}
		else if (p.equals("U")) {
			result = BbsPermission.UPDATE;
		}
		return result;
	}
}
