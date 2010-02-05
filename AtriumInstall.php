<?php

/**
 * @file
 * Install Open Atrium through browser.
 *
 * @todo Move configuration elements such as the path to the site and the 
 * browser to use out of this script.
 */

require_once 'PHPUnit/Extensions/SeleniumTestCase.php';

class AtriumInstall extends PHPUnit_Extensions_SeleniumTestCase
{
  function setUp()
  {
    $this->setBrowser("*firefox");
    $this->setBrowserUrl("http://localhost/atrium");
  }

  function testMyTestCase()
  {
    $this->open("/atrium/install.php");
    $this->click("edit-submit");
    $this->waitForPageToLoad("30000");
    $this->click("edit-submit");
    $this->waitForPageToLoad("30000");
    for ($second = 0; ; $second++) {
        if ($second >= 60) $this->fail("timeout");
        try {
            if ((bool)preg_match("/^http:\/\/localhost\/atrium\/install\.php[\s\S]profile=openatrium&locale=en$/",$this->getLocation())) break;
        } catch (Exception $e) {}
        sleep(1);
    }

    sleep(0.2);
    $this->type("edit-db-path", "atrium");
    $this->type("edit-db-user", "atrium");
    $this->type("edit-db-pass", "atrium");
    $this->click("edit-save");
    $this->waitForPageToLoad("30000");
    for ($second = 0; ; $second++) {
        if ($second >= 60) $this->fail("timeout");
        try {
            if ((bool)preg_match("/^http:\/\/localhost\/atrium\/install\.php[\s\S]locale=en&profile=openatrium$/",$this->getLocation())) break;
        } catch (Exception $e) {}
        sleep(1);
    }

    sleep(0.2);
    $this->type("edit-account-pass-pass1", "admin");
    $this->type("edit-account-pass-pass2", "admin");
    $this->select("edit-date-default-timezone-name", "label=America/New_York");
    $this->click("edit-submit");
    $this->waitForPageToLoad("30000");
    for ($second = 0; ; $second++) {
        if ($second >= 60) $this->fail("timeout");
        try {
            if ((bool)preg_match("/^http:\/\/localhost\/atrium\/install\.php[\s\S]locale=en&profile=openatrium$/",$this->getLocation())) break;
        } catch (Exception $e) {}
        sleep(1);
    }

    sleep(0.2);
    $this->click("link=your new site");
    $this->waitForPageToLoad("30000");
    try {
        $this->assertTrue($this->isTextPresent("Welcome to Open Atrium"));
    } catch (PHPUnit_Framework_AssertionFailedError $e) {
        array_push($this->verificationErrors, $e->toString());
    }
    try {
        $this->assertFalse($this->isTextPresent("warning"));
    } catch (PHPUnit_Framework_AssertionFailedError $e) {
        array_push($this->verificationErrors, $e->toString());
    }
    try {
        $this->assertFalse($this->isTextPresent("error"));
    } catch (PHPUnit_Framework_AssertionFailedError $e) {
        array_push($this->verificationErrors, $e->toString());
    }
  }
}
?>
