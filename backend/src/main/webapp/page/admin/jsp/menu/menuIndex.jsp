<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
	<head>
		<%@include file="/page/admin/jsp/common/common.jspf"%>
		<script src="${ctx}/static/js/menu/menuIndex.js?v=20261019"></script>
		<%@include file="/page/admin/jsp/common/title.jspf"%>
	</head>

	<body>

		<%@include file="/page/admin/jsp/common/head.jspf"%>

		<div class="main-container" id="main-container">
			<script type="text/javascript">
				try{ace.settings.check('main-container' , 'fixed');}catch(e){}
			</script>
			<div class="main-container-inner">
				<a class="menu-toggler" id="menu-toggler" href="javascript:void(0)">
					<span class="menu-text"></span>
				</a>

				<%@include file="/page/admin/jsp/common/menu.jspf"%>

				<div class="main-content">
					<div class="breadcrumbs" id="breadcrumbs">
						<script type="text/javascript">
							try{ace.settings.check('breadcrumbs' , 'fixed');}catch(e){}
						</script>
						<ul class="breadcrumb">
							<li>
								<i class="icon-home home-icon"></i>
								<a href="admin/pc/index">首页</a>
							</li>
							<li>
								<a>系统管理</a>
							</li>
							<li class="active">菜单管理</li>
						</ul>
						<div class="nav-search" id="nav-search">
							<input type="hidden" id="parentId" value="${parentId}" />
						</div>
					</div>
					<div class="page-content">
						<!-- <div class="page-header">
							<h1>
								菜单列表
								<small>
									<i class="icon-double-angle-right"></i>
								</small>
							</h1>
						</div> -->
						<div class="row">
							<div class="col-xs-12">
								<!-- PAGE CONTENT BEGINS -->
								<div class="row">
									<div class="col-sm-4">
										<div class="widget-box">
											<div class="widget-header header-color-blue2">
												<h4 class="lighter smaller">菜单树</h4>
											</div>
											<div class="widget-body">
												<div class="widget-main padding-8">
													<div id="menuTree" class="tree">
														<c:forEach var="rootMenu" items="${menuInitList}">
															<c:if test="${rootMenu.parentId eq 0}">
																<div class="menu-tree-root">
																	<label>
																		<input type="checkbox" class="ace" value="${rootMenu.id}" />
																		<span class="lbl"></span>
																	</label>
																	<i class="icon-folder-close blue"></i>
																	<span class="menu-tree-name">${rootMenu.name}</span>
																</div>
																<ul class="menu-tree-children">
																	<c:forEach var="childMenu" items="${rootMenu.children}">
																		<li>
																			<label>
																				<input type="checkbox" class="ace" value="${childMenu.id}" />
																				<span class="lbl"></span>
																			</label>
																			<span class="menu-tree-name">${childMenu.name}</span>
																			<span class="menu-tree-key">${childMenu.resKey}</span>
																		</li>
																	</c:forEach>
																</ul>
															</c:if>
														</c:forEach>
													</div>
												</div>
											</div>
										</div>
									</div>
									<div class="col-sm-8">
										<div id="menuDetail" class="menu-detail-panel"></div>
									</div>
								</div>
								<style>
									#menuTree { padding: 8px 10px; }
									.menu-tree-root { margin-top: 10px; font-size: 14px; color: #333; }
									.menu-tree-root .lbl { display: inline-block; width: 18px; }
									.menu-tree-name { margin-left: 6px; color: #333; }
									.menu-tree-key { margin-left: 8px; color: #999; font-size: 11px; }
									.menu-tree-children { margin: 4px 0 10px 26px; padding: 0; list-style: none; }
									.menu-tree-children li { padding: 5px 0; border-bottom: 1px dashed #eee; font-size: 13px; }
									.menu-detail-panel { background: #fff; min-height: 520px; }
								</style>
								<!-- PAGE CONTENT ENDS -->
							</div>
						</div>
					</div>
				</div>

				<%@include file="/page/admin/jsp/common/right.jspf"%>
				
			</div>
			<a href="javascript:void(0)" id="btn-scroll-up" class="btn-scroll-up btn btn-sm btn-inverse">
				<i class="icon-double-angle-up icon-only bigger-110"></i>
			</a>
		</div>

		<script src="${ctx}/static/ace/assets/js/ajax/libs/jquery/2.0.3/jquery.min.js"></script>
		<script type="text/javascript">
			window.jQuery || document.write("<script src='${ctx}/static/ace/assets/js/jquery-2.0.3.min.js'>"+"<"+"/script>");
		</script>
		<script type="text/javascript">
			if("ontouchend" in document) document.write("<script src='${ctx}/static/ace/assets/js/jquery.mobile.custom.min.js'>"+"<"+"/script>");
		</script>
		<script src="${ctx}/static/ace/assets/js/bootstrap.min.js"></script>
		<script src="${ctx}/static/ace/assets/js/typeahead-bs2.min.js"></script>
		<script src="${ctx}/static/ace/assets/js/fuelux/data/fuelux.tree-sampledata.js"></script>
		<script src="${ctx}/static/ace/assets/js/fuelux/fuelux.tree.min.js"></script>
		<script src="${ctx}/static/ace/assets/js/ace-elements.min.js"></script>
		<script src="${ctx}/static/ace/assets/js/ace.min.js"></script>
		
		<script src="${ctx}/static/ace/assets/js/jquery-ui-1.10.3.full.min.js"></script>
		
	</body>
</html>
