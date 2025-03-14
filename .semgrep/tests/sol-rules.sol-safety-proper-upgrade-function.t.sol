// Semgrep tests for Solidity rules are defined in this file.
// Semgrep tests do not need to be valid Solidity code but should be syntactically correct so that
// Semgrep can parse them. You don't need to be able to *run* the code here but it should look like
// the code that you expect to catch with the rule.
//
// Semgrep testing 101
// Use comments like "ruleid: <rule-id>" to assert that the rule catches the code.
// Use comments like "ok: <rule-id>" to assert that the rule does not catch the code.

/// NOTE: Semgrep limitations mean that the rule for this check is defined as a relatively loose regex that searches the
/// remainder of the file after the `@custom:proxied` natspec tag is detected. This means that we must test the case
/// without this natspec tag BEFORE the case with the tag or the rule will apply to the remainder of the file.

// If no proxied natspec, upgrade functions can have no upgrade modifier and be public or external
contract SemgrepTest__sol_safety_proper_upgrade_function_1 {
    // ok: sol-safety-proper-upgrade-function
    function upgrade() external {
        // ...
    }

    // ok: sol-safety-proper-upgrade-function
    function upgrade() public {
        // ...
    }
}

/// NOTE: the proxied natspec below is valid for all contracts after this one
/// @custom:proxied true
contract SemgrepTest__sol_safety_proper_upgrade_function_2 {
    // ok: sol-safety-proper-upgrade-function
    function upgrade() external reinitializer(1) {
        // ...
    }

    // ok: sol-safety-proper-upgrade-function
    function upgrade() external reinitializer(1) {
        // ...
    }

    // ruleid: sol-safety-proper-upgrade-function
    function upgrade() public reinitializer(2) {
        // ...
    }

    // ruleid: sol-safety-proper-upgrade-function
    function upgrade() external initializer {
        // ...
    }

    // ruleid: sol-safety-proper-upgrade-function
    function upgrade() public initializer {
        // ...
    }

    // ruleid: sol-safety-proper-upgrade-function
    function upgrade() external {
        // ...
    }

    // ruleid: sol-safety-proper-upgrade-function
    function upgrade() public {
        // ...
    }
}
