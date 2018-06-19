<%@page import="customerFAQ.model.vo.CustomerFAQ"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/views/common/header.jsp"%>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/nav-tabs.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/customer.css">

<section>
	<div class='container'>
		<div class="panel">

			<ul class="nav nav-tabs">
				<li role="presentation"><a href="<%=request.getContextPath()%>/customer.do">공지사항</a></li>
				<li class="active" role="presentation"><a href="<%=request.getContextPath()%>/customerFAQForm.do">자주묻는 질문</a></li>
				<li role="presentation"><a href="<%=request.getContextPath()%>/customerStoreSignup.do">점포가입신청</a></li>
			</ul>

			<div class="panel-body">
				<div class="page-header">
					<h2>자주 묻는 질문 등록</h2>
				</div>
				<form class="form-horizontal" action="<%=request.getContextPath()%>/customerNewFAQFormEnd.do"
					method="post">

					<div class="form-group">
						<label class="col-sm-3 control-label" for="">아이디 </label>
						<div class="col-sm-6">
							<input class="form-control" type="text" value="<%=memberLoggedIn.getMemberId() %>"
								width="100" readonly>
						</div>
					</div>


					<div class="form-group">
						<label class="col-sm-3 control-label" for="">제목 </label>
						<div class="col-sm-6">
							<input class="form-control" type="text" id="faqTitle" name="FAQTitle" placeholder="제목을 입력하세요.">
						</div>
					</div>

					<div class="form-group">

						<label for="" class="col-sm-3 control-label">내 용 </label>
						<div class="col-sm-6">
							<textarea class="form-control" rows="13" id="faqContent" name="FAQContent" style="resize: none;"></textarea>
						</div>

					</div>
					<hr>
					<div class="row">
						<div class="form-group">
							<div class="col-sm-12 text-center">
								<button class="btn btn-primary" type="submit"
									onclick="return fn_FAQCheck();">
									제출하기<i class="fa fa-check spaceLeft"></i>
								</button>
								<button class="btn btn-danger" type="reset">
									취소<i class="fa fa-times spaceLeft"></i>
								</button>
							</div>
						</div>
					</div>
				</form>
				<script>
			     
                function fn_FAQCheck(){
                	  var title=$("#faqTitle").val();
                      var content=$("#faqContent").val();
						
                      title=$.trim(title);
                      content=$.trim(content);
                	
                if(title.length==0||title==null){
                  alert("제목을 입력하세요")
                  $("#faqTitle").focus();
                  return false;
                }
                
                if(content.length==0||content==null){
                  alert("내용을 입력하세요");
                  $("#faqContent").focus();
                   return false;
                }
                  return true;
                }
               
				</script>

			</div>

		</div>
	</div>
</section>

<%@ include file="/views/common/footer.jsp"%>