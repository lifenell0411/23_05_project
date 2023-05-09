package com.KoreaIT.bjw._05_project.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.KoreaIT.bjw._05_project.service.ArticleService;
import com.KoreaIT.bjw._05_project.service.ReplyService;
import com.KoreaIT.bjw._05_project.util.Ut;
import com.KoreaIT.bjw._05_project.vo.Article;
import com.KoreaIT.bjw._05_project.vo.Reply;
import com.KoreaIT.bjw._05_project.vo.ResultData;
import com.KoreaIT.bjw._05_project.vo.Rq;

@Controller
public class UsrReplyController {

	@Autowired
	private Rq rq;
	@Autowired
	private ReplyService replyService;
	@Autowired
	private ArticleService articleService;

	@RequestMapping("/usr/reply/doWrite")
	@ResponseBody
	public String doWrite(String relTypeCode, int relId, String body, String replaceUri) {

		if (Ut.empty(relTypeCode)) {
			return rq.jsHitoryBack("F-1", "relTypeCode 을(를) 입력해주세요");
		}
		if (Ut.empty(relId)) {
			return rq.jsHitoryBack("F-2", "relId 을(를) 입력해주세요");
		}
		if (Ut.empty(body)) {
			return rq.jsHitoryBack("F-3", "body 을(를) 입력해주세요");
		}

		ResultData<Integer> writeReplyRd = replyService.writeReply(rq.getLoginedMemberId(), relTypeCode, relId, body);

		int id = (int) writeReplyRd.getData1();

		if (Ut.empty(replaceUri)) {
			replaceUri = Ut.f("../article/detail?id=%d", relId);
		}

		return rq.jsReplace(writeReplyRd.getMsg(), replaceUri);
	}

	@RequestMapping("/usr/reply/doDelete")
	@ResponseBody
	public String doDelete(int id, String replaceUri) {

		Reply reply = replyService.getReply(id);

		if (reply == null) {
			return Ut.jsHitoryBack("F-1", Ut.f("%d번 댓글은 존재하지 않습니다", id));
		}

		if (reply.getMemberId() != rq.getLoginedMemberId()) {
			return Ut.jsHitoryBack("F-2", Ut.f("%d번 댓글에 대한 권한이 없습니다", id));
		}

		ResultData deleteReplyRd = replyService.deleteReply(id);

		if (Ut.empty(replaceUri)) {
			switch (reply.getRelTypeCode()) {
			case "article":
				replaceUri = Ut.f("../article/detail?id=%d", reply.getRelId());
				break;
			}
		}

		return Ut.jsReplace(deleteReplyRd.getMsg(), replaceUri);
	}

	@RequestMapping("/usr/reply/modify")
	public String showModify(Model model, int id, String replaceUri) {

		Reply reply = replyService.getForPrintReply(rq.getLoginedMemberId(), id);

		if (reply == null) {
			return rq.jsHitoryBackOnView(Ut.f("%d번 댓글은 존재하지 않습니다!", id));
		}

		ResultData actorCanModifyRd = replyService.actorCanModify(rq.getLoginedMemberId(), reply);

		if (actorCanModifyRd.isFail()) {
			return rq.jsHitoryBackOnView(actorCanModifyRd.getMsg());
		}

		Article article = articleService.getArticle(reply.getRelId());

		model.addAttribute("reply", reply);
		model.addAttribute("article", article);

		return "usr/reply/modify";
	}

	@RequestMapping("/usr/reply/doModify")
	@ResponseBody
	public String doModify(int id, String body, String replaceUri) {

		Reply reply = replyService.getReply(id);

		if (reply == null) {
			return rq.jsHitoryBack("F-1", Ut.f("%d번 댓글은 존재하지 않습니다", id));
		}

		ResultData actorCanModifyRd = replyService.actorCanModify(rq.getLoginedMemberId(), reply);

		if (actorCanModifyRd.isFail()) {
			return rq.jsHitoryBack(actorCanModifyRd.getResultCode(), actorCanModifyRd.getMsg());
		}

		ResultData modifyReplyRd = replyService.modifyReply(id, body);

		if (Ut.empty(replaceUri)) {
			switch (reply.getRelTypeCode()) {
			case "article":
				replaceUri = Ut.f("../article/detail?id=%d", reply.getRelId());
				break;
			}
		}

		return rq.jsReplace(modifyReplyRd.getMsg(), replaceUri);
	}

}