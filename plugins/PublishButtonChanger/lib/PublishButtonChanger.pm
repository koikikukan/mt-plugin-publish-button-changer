package PublishButtonChanger;

use strict;

sub confirm {
    my ($cb, $app, $tmpl) = @_;

    my $old = <<HERE;
        <button
            mt:mode="save_entry"
            name="status"
            type="submit"
            title="<mt:var name="button_title">"
            class="publish action primary-button"
            value="2"
            ><mt:var name="button_text"></button>
HERE
    $old = quotemeta($old);

    my $new = <<HERE;
<mt:if name="button_text" eq="<__trans phrase="Publish">">
        <button
            mt:mode="save_entry"
            name="status"
            type="submit"
            title="<mt:var name="button_title">"
            class="publish action"
            value="2"
            ><mt:var name="button_text"></button>
<mt:else>
        <button
            mt:mode="save_entry"
            name="status"
            type="submit"
            title="<mt:var name="button_title">"
            class="publish action  primary-button"
            value="2"
            ><mt:var name="button_text"></button>
</mt:if>
HERE
    $$tmpl =~ s/$old/$new/;

    $old = <<HERE;
        <button
            mt:mode="save_entry"
            type="submit"
            title="<mt:var name="draft_button_title">"
            class="save draft action"
            value="1"
            ><mt:var name="draft_button_text"></button>
HERE
    $old = quotemeta($old);

    my $new = <<HERE;
<mt:if name="draft_button_text" eq="<__trans phrase="Save Draft">">
        <button
            mt:mode="save_entry"
            type="submit"
            title="<mt:var name="draft_button_title">"
            class="save draft action primary-button"
            value="1"
            ><mt:var name="draft_button_text"></button>
<mt:else>
        <button
            mt:mode="save_entry"
            type="submit"
            title="<mt:var name="draft_button_title">"
            class="save draft action"
            value="1"
            ><mt:var name="draft_button_text"></button>
</mt:if>
HERE
    $$tmpl =~ s/$old/$new/;

    $old = <<HERE;
<mt:include name="include/header.tmpl" id="header_include">
HERE
    $old = quotemeta($old);

    $new = <<HERE;
<mt:include name="include/header.tmpl" id="header_include">
<style type="text/css">
.attention-button {
    color: #ff0000;
}
</style>
HERE

    $$tmpl =~ s/$old/$new/;

    $old = <<HERE;
    jQuery('button.publish').click(function(event) {
        jQuery('form#entry_form > input[name=status]').val(2);
    });
HERE
    $old = quotemeta($old);

    my $plugin = MT->component("PublishButtonChanger");
    my $scope = "blog:" . $app->blog->id;
    my $message = $plugin->get_config_value('message', $scope);

    $new = <<HERE;
    jQuery('button.publish').click(function(event) {
        jQuery('form#entry_form > input[name=status]').val(2);
        if (window.confirm('$message')) {
            documen.entry_form.submit();
        } else {
            return false;
        }
    });
HERE

    $$tmpl =~ s/$old/$new/;

}

1;
