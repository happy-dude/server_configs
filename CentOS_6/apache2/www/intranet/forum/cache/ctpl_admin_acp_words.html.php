<?php if (!defined('IN_PHPBB')) exit; $this->_tpl_include('overall_header.html'); ?>


<a name="maincontent"></a>

<?php if ($this->_rootref['S_EDIT_WORD']) {  ?>


	<a href="<?php echo (isset($this->_rootref['U_BACK'])) ? $this->_rootref['U_BACK'] : ''; ?>" style="float: <?php echo (isset($this->_rootref['S_CONTENT_FLOW_END'])) ? $this->_rootref['S_CONTENT_FLOW_END'] : ''; ?>;">&laquo; <?php echo ((isset($this->_rootref['L_BACK'])) ? $this->_rootref['L_BACK'] : ((isset($user->lang['BACK'])) ? $user->lang['BACK'] : '{ BACK }')); ?></a>

	<h1><?php echo ((isset($this->_rootref['L_ACP_WORDS'])) ? $this->_rootref['L_ACP_WORDS'] : ((isset($user->lang['ACP_WORDS'])) ? $user->lang['ACP_WORDS'] : '{ ACP_WORDS }')); ?></h1>

	<p><?php echo ((isset($this->_rootref['L_ACP_WORDS_EXPLAIN'])) ? $this->_rootref['L_ACP_WORDS_EXPLAIN'] : ((isset($user->lang['ACP_WORDS_EXPLAIN'])) ? $user->lang['ACP_WORDS_EXPLAIN'] : '{ ACP_WORDS_EXPLAIN }')); ?></p>

	<form id="acp_words" method="post" action="<?php echo (isset($this->_rootref['U_ACTION'])) ? $this->_rootref['U_ACTION'] : ''; ?>">

	<fieldset>
		<legend><?php echo ((isset($this->_rootref['L_EDIT_WORD'])) ? $this->_rootref['L_EDIT_WORD'] : ((isset($user->lang['EDIT_WORD'])) ? $user->lang['EDIT_WORD'] : '{ EDIT_WORD }')); ?></legend>
		<dl>
			<dt><label for="word"><?php echo ((isset($this->_rootref['L_WORD'])) ? $this->_rootref['L_WORD'] : ((isset($user->lang['WORD'])) ? $user->lang['WORD'] : '{ WORD }')); ?></label></dt>
			<dd><input id="word" type="text" name="word" value="<?php echo (isset($this->_rootref['WORD'])) ? $this->_rootref['WORD'] : ''; ?>" maxlength="255" /></dd>
		</dl>
		<dl>
			<dt><label for="replacement"><?php echo ((isset($this->_rootref['L_REPLACEMENT'])) ? $this->_rootref['L_REPLACEMENT'] : ((isset($user->lang['REPLACEMENT'])) ? $user->lang['REPLACEMENT'] : '{ REPLACEMENT }')); ?></label></dt>
			<dd><input id="replacement" type="text" name="replacement" value="<?php echo (isset($this->_rootref['REPLACEMENT'])) ? $this->_rootref['REPLACEMENT'] : ''; ?>" maxlength="255" /></dd>
		</dl>
		<?php echo (isset($this->_rootref['S_HIDDEN_FIELDS'])) ? $this->_rootref['S_HIDDEN_FIELDS'] : ''; ?>


	<p class="submit-buttons">
		<input class="button1" type="submit" id="submit" name="save" value="<?php echo ((isset($this->_rootref['L_SUBMIT'])) ? $this->_rootref['L_SUBMIT'] : ((isset($user->lang['SUBMIT'])) ? $user->lang['SUBMIT'] : '{ SUBMIT }')); ?>" />&nbsp;
		<input class="button2" type="reset" id="reset" name="reset" value="<?php echo ((isset($this->_rootref['L_RESET'])) ? $this->_rootref['L_RESET'] : ((isset($user->lang['RESET'])) ? $user->lang['RESET'] : '{ RESET }')); ?>" />
		<?php echo (isset($this->_rootref['S_FORM_TOKEN'])) ? $this->_rootref['S_FORM_TOKEN'] : ''; ?>

	</p>
	</fieldset>
	</form>

<?php } else { ?>


	<h1><?php echo ((isset($this->_rootref['L_ACP_WORDS'])) ? $this->_rootref['L_ACP_WORDS'] : ((isset($user->lang['ACP_WORDS'])) ? $user->lang['ACP_WORDS'] : '{ ACP_WORDS }')); ?></h1>

	<p><?php echo ((isset($this->_rootref['L_ACP_WORDS_EXPLAIN'])) ? $this->_rootref['L_ACP_WORDS_EXPLAIN'] : ((isset($user->lang['ACP_WORDS_EXPLAIN'])) ? $user->lang['ACP_WORDS_EXPLAIN'] : '{ ACP_WORDS_EXPLAIN }')); ?></p>

	<form id="acp_words" method="post" action="<?php echo (isset($this->_rootref['U_ACTION'])) ? $this->_rootref['U_ACTION'] : ''; ?>">

	<fieldset class="tabulated">
	<legend><?php echo ((isset($this->_rootref['L_ACP_WORDS'])) ? $this->_rootref['L_ACP_WORDS'] : ((isset($user->lang['ACP_WORDS'])) ? $user->lang['ACP_WORDS'] : '{ ACP_WORDS }')); ?></legend>
	<p class="quick">
		<?php echo (isset($this->_rootref['S_HIDDEN_FIELDS'])) ? $this->_rootref['S_HIDDEN_FIELDS'] : ''; ?>

		<input class="button2" name="add" type="submit" value="<?php echo ((isset($this->_rootref['L_ADD_WORD'])) ? $this->_rootref['L_ADD_WORD'] : ((isset($user->lang['ADD_WORD'])) ? $user->lang['ADD_WORD'] : '{ ADD_WORD }')); ?>" />
	</p>

	<table cellspacing="1">
	<thead>
	<tr>
		<th><?php echo ((isset($this->_rootref['L_WORD'])) ? $this->_rootref['L_WORD'] : ((isset($user->lang['WORD'])) ? $user->lang['WORD'] : '{ WORD }')); ?></th>
		<th><?php echo ((isset($this->_rootref['L_REPLACEMENT'])) ? $this->_rootref['L_REPLACEMENT'] : ((isset($user->lang['REPLACEMENT'])) ? $user->lang['REPLACEMENT'] : '{ REPLACEMENT }')); ?></th>
		<th><?php echo ((isset($this->_rootref['L_ACTION'])) ? $this->_rootref['L_ACTION'] : ((isset($user->lang['ACTION'])) ? $user->lang['ACTION'] : '{ ACTION }')); ?></th>
	</tr>
	</thead>
	<tbody>
	<?php $_words_count = (isset($this->_tpldata['words'])) ? sizeof($this->_tpldata['words']) : 0;if ($_words_count) {for ($_words_i = 0; $_words_i < $_words_count; ++$_words_i){$_words_val = &$this->_tpldata['words'][$_words_i]; if (!($_words_val['S_ROW_COUNT'] & 1)  ) {  ?><tr class="row1"><?php } else { ?><tr class="row2"><?php } ?>

		<td style="text-align: center;"><?php echo $_words_val['WORD']; ?></td>
		<td style="text-align: center;"><?php echo $_words_val['REPLACEMENT']; ?></td>
		<td>&nbsp;<a href="<?php echo $_words_val['U_EDIT']; ?>"><?php echo (isset($this->_rootref['ICON_EDIT'])) ? $this->_rootref['ICON_EDIT'] : ''; ?></a>&nbsp;&nbsp;<a href="<?php echo $_words_val['U_DELETE']; ?>"><?php echo (isset($this->_rootref['ICON_DELETE'])) ? $this->_rootref['ICON_DELETE'] : ''; ?></a>&nbsp;</td>
	</tr>
	<?php }} else { ?>

	<tr class="row3">
		<td colspan="3"><?php echo ((isset($this->_rootref['L_ACP_NO_ITEMS'])) ? $this->_rootref['L_ACP_NO_ITEMS'] : ((isset($user->lang['ACP_NO_ITEMS'])) ? $user->lang['ACP_NO_ITEMS'] : '{ ACP_NO_ITEMS }')); ?></td>
	</tr>
	<?php } ?>

	</tbody>
	</table>
	<?php echo (isset($this->_rootref['S_FORM_TOKEN'])) ? $this->_rootref['S_FORM_TOKEN'] : ''; ?>

	</fieldset>
	</form>
<?php } $this->_tpl_include('overall_footer.html'); ?>