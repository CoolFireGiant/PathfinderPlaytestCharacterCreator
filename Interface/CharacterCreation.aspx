﻿<%@ Page Title="Character Creation" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CharacterCreation.aspx.cs" Inherits="Interface.CharacterCreation" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

	<h1>Character Creation</h1>
	<div class="row">
		<div class="col-md-2">
			<ul class="nav nav-pills nav-stacked">
				<li class="active"><a data-toggle="pill" href="#tabAncestry">Ancestry</a></li>
				<li><a data-toggle="pill" href="#tabBackgroung">Backgroung</a></li>
				<li><a data-toggle="pill" href="#tabClass">Class</a></li>
				<li><a data-toggle="pill" href="#tabAbilityScores">Ability Scores</a></li>
			</ul>
		</div>
		<div class="col-md-10 tab-content">
			<div id="tabAncestry" class="tab-pane fade in active">
				<h2>Ancestry</h2>
				<p>Your character’s heritage determines which of the world’s many peoples she calls her own, whether it’s diverse humans, insular but vivacious elves, traditionalist and family-focused dwarves, or any of the other groups of people that call Golarion home. Both her heritage and her experiences as a youth might be key parts of her identity, and they likely shape how she sees the world and her place in it.</p>
				<div>
					<div class="col-md-2">
						<ul id="menuAncestry" class="nav nav-pills nav-stacked">
						</ul>
					</div>
					<div id="mainAncestry" class="col-md-10 tab-content">
					</div>
				</div>
			</div>
			<div id="tabBackgroung" class="tab-pane fade">
				<h2>Background</h2>
				<p>Backgrounds allow you to customize your character based on her life before adventuring. Your character’s background can help you learn or portray more about her personality while suggesting what sorts of things she’s likely to know. Each background grants two ability boosts, a bonus skill feat, and training in one Lore skill. A character can have only one background, chosen at 1st level, and it can’t be changed.</p>
				<div id="panelBackground">
					<div class="col-md-2">
						<ul class="nav nav-pills nav-stacked">
						</ul>
					</div>
					<div class="col-md-10 tab-content">
					</div>
				</div>
			</div>
			<div id="tabClass" class="tab-pane fade">
				<h2>Class</h2>
				<p>Just as your character’s ancestry plays a key role in expressing her identity and worldview, her class indicates the training she has developed and will improve upon as an adventurer. Groups of players often wish to create characters whose skills and abilities synergize mechanically, and in this respect, choosing your character’s class is perhaps the most important decision you will make for her.</p>
				<div id="panelClass">
					<div class="col-md-2">
						<ul class="nav nav-pills nav-stacked">
						</ul>
					</div>
					<div class="col-md-10 tab-content">
					</div>
				</div>
			</div>
			<div id="tabAbilityScores" class="tab-pane fade">
				<h2>Ability Scores</h2>
				<p>Your character has six ability scores that represent her basic attributes and raw potential: Strength, Dexterity, Constitution, Intelligence, Wisdom, and Charisma. These scores each influence different aspects of your character’s capabilities. As your character progresses through the game’s story and increases in level, she gains ability boosts that improve her ability scores, allowing you to decide how her experiences have developed her raw capabilities.</p>
				<div id="panelAbilityScores">
					<div class="col-md-2">
						<ul class="nav nav-pills nav-stacked">
						</ul>
					</div>
					<div class="col-md-10 tab-content">
					</div>
				</div>
			</div>
		</div>
	</div>
	<script src="Lists/AncestryList.js"></script>
	<script src="Lists/BackgroundList.js"></script>
	<script src="Lists/ClassList.js"></script>
	<script src="Lists/FeatList.js"></script>
	<script src="Lists/SpellList.js"></script>
	<script src="Lists/PanelModels.js"></script>
	<script type="text/javascript">

		$(function () {

			var steps = [
				"Ancestry",
				//"Background",
				//"Class"
			];

			var Lists = {
				Ancestry: AncestryList,
				Background: BackgroundList,
				Class: ClassList
			};

			var PageModels = {
				Ancestry: getAncestryPage,
				Background: getBackgroundPage,
				Class: getClassPage
			};

			var OptionSelectedHandlers = {
				Ancestry: AncestrySelectedHandler,
				Background: BackgroundSelectedHandler,
				Class: ClassSelectedHandler
			}

			//Iterates through a list of strings, one for each tab;
			$.each(steps, function (index, step) {
				//gets the tab's menu where to add new options;
				var menu = $('#menu' + step);

				//iterates through all tab's objects;
				$.each(Lists[step], function (index, obj) {
					//creates a tab for the object in the menu;
					menu.append('<li><a data-toggle="pill" href="#panel' + step + obj.Id + '" step="' + step + '" objid="' + obj.Id + '">' + obj.Name + '</a></li>');
					//adds click handler to the tab, which loads the tab's content if it did't yet do it;
					menu.find('a:last').click(buildPanel);
				});
				//$('#menu' + step + ' a:first').addClass("active").click();
			});

			function buildPanel(e) {
				//gets the object's Id;
				var id = e.target.attributes['objid'].value;
				//gets the step`s name;
				var step = e.target.attributes['step'].value;

				//if the panel has not been created, it creates it;
				if (id && step && !$('#panel' + step + id)[0]) {
					// gets the object;
					var obj = Lists[step][id];
					//adds a new panel using the corresponding model and the object that will fill it up;
					$('#main' + step).append(PageModels[step](obj));
					//adds select handler to the radio button;
					$('#button' + step + id).click(obj, OptionSelectedHandlers[step]);
				}
			}

			function AncestrySelectedHandler(a) {

			}

			function BackgroundSelectedHandler(b) {

			}

			function ClassSelectedHandler(c) {

			}

			//function montarFiltros(retorno) {
			//	var idRel = retorno.d.IdRelatorio;
			//	var filtros = retorno.d.Filtros;
			//	Relatorios.buscarRelatorio(idRel).Filtros = filtros;
			//	if (!filtros[0]) { return; }

			//	//var datePickerHTML = '<div class="col-md-6"><b><br/>{0}:</b><input id="{1}" class="form-control" type="date"></div>';
			//	var datePickerHTML = '<div class="col-md-6"><b><br/>{0}:</b><div class="input-daterange input-group" id="{1}"><input class="input-sm form-control" name="start" type="text" /><span class="input-group-addon">até</span><input type="text" class="input-sm form-control" name="end" /></div>';
			//	var dropDownListHTML = '<div class="col-md-6"><b><br/>{0}:</b><select id="{1}" class="selectpicker form-control" data-live-search="true"></div>';
			//	var dropDownMultipleHTML = '<div class="col-md-6"><b><br/>{0}:</b><select id="{1}" class="selectpicker form-control" data-live-search="true" multiple title="Todos"></div>';
			//	var numberBoxHTML = '<div class="col-md-6"><b><br/>{0}:</b><input id="{1}" class="form-control" type="number"></div>';
			//	var textBoxHTML = '<div class="col-md-6"><b><br/>{0}:</b><input id="{1}" class="form-control" type="text"></div>';

			//	var idFiltro, descricao;
			//	painelFiltros = $('div#painelRel' + idRel + ' fieldset.painelFiltros');
			//	for (var i = 0; i < filtros.length; i++) {
			//		idFiltro = filtros[i].CampoFiltro + idRel;
			//		descricao = filtros[i].Descricao;
			//		switch (filtros[i].TipoCampo) {
			//			case "D":
			//				painelFiltros.append(datePickerHTML.replace('{0}', descricao).replace('{1}', idFiltro));
			//				break;
			//			case "L":
			//				painelFiltros.append(dropDownListHTML.replace('{0}', descricao).replace('{1}', idFiltro));
			//				$('#' + idFiltro).append($('<option />').val(null).text('Todos'));
			//				$.each(filtros[i].Lista, function () { $('#' + idFiltro).append($('<option />').val(this).text(this)); });
			//				break;
			//			case "M":
			//				painelFiltros.append(dropDownMultipleHTML.replace('{0}', descricao).replace('{1}', idFiltro));
			//				$.each(filtros[i].Lista, function () { $('#' + idFiltro).append($('<option />').val(this).text(this)); });
			//				break;
			//			case "N":
			//				painelFiltros.append(numberBoxHTML.replace('{0}', descricao).replace('{1}', idFiltro));
			//				break;
			//			case "T":
			//				painelFiltros.append(textBoxHTML.replace('{0}', descricao).replace('{1}', idFiltro));
			//		}
			//	}
			//	$('.selectpicker').selectpicker({ size: 6 });
			//	$('.input-daterange').datepicker({
			//		format: "dd/mm/yyyy",
			//		clearBtn: true,
			//		language: "pt-BR",
			//		todayHighlight: true
			//	});
			//}

			//function gerarExcel(e) {
			//	var id = e.target.attributes['idrel'].value;
			//	var rel = Relatorios.buscarRelatorio(id);
			//	var painel = $('#painelRel' + id)[0];
			//	var idFiltro;
			//	$.each(rel.Filtros, function () {
			//		idFiltro = '#' + this.CampoFiltro + this.IdRelatorio;
			//		switch (this.TipoCampo) {
			//			case "D":
			//				this.ValorSelecionado = [$(idFiltro)[0].children[0].value, $(idFiltro)[0].children[2].value];
			//				break;
			//			case "L":
			//				this.ValorSelecionado = $(idFiltro)[0].selectedOptions[0].value;
			//				break;
			//			case "M":
			//				this.ValorSelecionado = pegarListaValores($(idFiltro)[0].selectedOptions);
			//				break;
			//			case "N":
			//			case "T":
			//				this.ValorSelecionado = $(idFiltro)[0].value;
			//				break;
			//		}
			//	});
			//	//window.location.href = 'GerarRelatorioExcel.ashx?rel=' + JSON.stringify(rel);
			//	window.location.href = 'RelatoriosBS.aspx?rel=' + JSON.stringify(rel);
			//}

			//function pegarListaValores(lista) {
			//	var valores = [];
			//	$.each(lista, function () {
			//		valores.push(this.value);
			//	});
			//	return valores;
			//}

			////#######################
			//// Funções assistenciais
			////#######################

			//function loaderIn() {
			//	$(".loader").fadeIn('fast');
			//}

			//function loaderOut() {
			//	$(".loader").fadeOut('fast');
			//}

			//function doAjax(url, data, onSuccess, onFailure) {
			//	$.ajax({
			//		type: "POST",
			//		url: url,
			//		contentType: "application/json; charset=utf-8",
			//		data: JSON.stringify(data),
			//		dataType: "json",
			//		beforeSend: loaderIn,
			//		success: onSuccess,
			//		failure: onFailure,
			//		error: erro,
			//		complete: loaderOut
			//	});
			//}

			//function sucesso(retorno, x, y) {
			//	alert(retorno.d);
			//}

			//function erro(retorno, x, y) {
			//	retornar = false;
			//	alert("Houve um erro na operação:\n\n" + retorno.d);
			//}

			//function falha(retorno, x, y) {
			//	retornar = false;
			//	alert("Houve uma falha na operação:\n\n" + retorno.d);
			//}

		});

	</script>
</asp:Content>
