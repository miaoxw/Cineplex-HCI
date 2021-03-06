<%@page import="vo.ActivityVO"%>
<%@page import="java.util.List"%>
<%@ page import="com.opensymphony.xwork2.ActionContext"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="MyTag" uri="/WEB-INF/tlds/checkSession.tld"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Activity</title>
<meta charset="utf-8">
<link rel="stylesheet" type="text/css" media="screen"
	href="../css/reset.css">
<link rel="stylesheet" type="text/css" media="screen"
	href="../css/style.css">
<link rel="stylesheet" type="text/css" media="screen"
	href="../css/grid_12.css">
<script src="../js/jquery-1.7.min.js"></script>
<script src="../js/jquery.easing.1.3.js"></script>
<script src="../js/cufon-yui.js"></script>
<script src="../js/Vegur-L_300.font.js"></script>
<script src="../js/Vegur-M_500.font.js"></script>
<script src="../js/Vegur-R_400.font.js"></script>
<script src="../js/cufon-replace.js"></script>
<script src="../js/FF-cash.js"></script>
</head>
<body>
	<MyTag:checkSession test="${sessionScope.account_id == null}">
		<%
			response.sendRedirect("login.jsp");
		%>
	</MyTag:checkSession>
	<!--==============================header=================================-->

	<%
		String memberName = (String) ActionContext.getContext()
				.getSession().get("memberName");
	%>

	<MyTag:checkSession test="${sessionScope.account_id != null}">
		<header>
			<div class="main">
				<%@include file="header.jsp"%>
				<nav>
					<ul class="right">
						<li>Welcome <a href="infoPro?modify=1"><%=memberName%></a>&nbsp;&nbsp;|&nbsp;&nbsp;<a
							href="infoPro?modify=1">My Account</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a
							href="logoutPro">Log out</a></li>
					</ul>
					<ul class="menu">
						<li><a href="index.jsp">Home</a></li>
						<li><a href="allMoviesPro">Ticket</a></li>
						<li class="current"><a href="activityArrangePro">Activity</a></li>
						<li><a href="recordPro">History</a></li>
						<li><a href="charge.jsp">Charge</a></li>
						<li><a href="about.jsp">About</a></li>
					</ul>
				</nav>
			</div>
		</header>
		<section id="header-content">
			<div class="main">
				<div class="sub-page-banner big-image5">
					<p>
						<strong class="font-1">Use</strong><strong class="font-2">Activity</strong><strong
							class="font-1">to</strong><strong class="font-2">attend!</strong>
					</p>
				</div>
			</div>
		</section>
		<!--==============================content================================-->
		<section id="content" class="border subpage-content">
			<div class="ic"></div>
			<div class="container_12">
				<%
					if (request.getAttribute("noQuestion") == null) {
							if (request.getAttribute("activityList") != null) {
								@SuppressWarnings("unchecked")
								List<ActivityVO> activityList = (List<ActivityVO>) request
										.getAttribute("activityList");
								if (activityList.size() == 0) {
				%>
				<div class="grid_12">
					<div class="pad-1">
						<h2 class="p3">No Activity</h2>
					</div>
				</div>

				<%
					} else {
									for (int i = 0; i < activityList.size(); i++) {
										ActivityVO activity = activityList.get(i);
				%>
				<div class="grid_12">
					<div class="pad-1 wrap top-2">
						<h2 class="h2">
							Question about
							<%=activity.getMovie_name()%></h2>
						<div class="wrap block-6">
							<div class="img-indent-3">
								<img src="<%=activity.getPic()%>" alt=""
									class="left-2 img-radius" height="200" width="180">
							</div>
							<div class="extra-wrap1">
								<p class="p2"><%=activity.getIntroduction()%></p>
								<p class="color-1 p2">
									<%=activity.getQuestion()%>&nbsp;&nbsp;&nbsp;<label
										class="red1 font1">Credits: <%=activity.getCredit()%></label>
								</p>
								<form
									action="answerQuestionPro?question_id=<%=activity.getQuestionId()%>"
									autocomplete="on" method="post">
									<div>
										<%
											String answer = activity.getAnswer();
																boolean hasAnswer = (answer.equals("")) ? false
																		: true;
										%>
										<input type="radio" name="answer" value="a1"
											<%if (answer.equals("a1") || (!hasAnswer)) {%>
											checked="checked" <%}%>><label><%=((String) activity.getOption())
										.split("&&")[0]%></label><input type="radio" name="answer" value="a2"
											class="left-6" <%if (answer.equals("a2")) {%>
											checked="checked" <%}%>><label><%=((String) activity.getOption())
										.split("&&")[1]%></label><input type="radio" name="answer" value="a3"
											class="left-6" <%if (answer.equals("a3")) {%>
											checked="checked" <%}%>><label><%=((String) activity.getOption())
										.split("&&")[2]%></label>

									</div>
									<input type="submit" class="button-2-right"
										value="<%=activity.getSubmit()%>" />
								</form>
							</div>
						</div>
					</div>
				</div>
				<%
					}
								}
							}
						} else {
				%>
				<div class="grid_12">
					<div class="pad-1">
						<h2 class="p3">No Question</h2>
					</div>
				</div>
				<%
					}
				%>
				<div class="clear"></div>
			</div>
		</section>
		<!--==============================footer=================================-->
		<%@include file="footer.jsp"%>
	</MyTag:checkSession>
</body>
</html>