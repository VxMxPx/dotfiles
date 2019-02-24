#!/usr/bin/env php
<?php

$arguments = $_SERVER['argv'];

if (!isset($arguments[1]))
{
  echo "Please enter choices: ";
  $choices = fread(STDIN, 8192);
}
else
{
  $choices = $arguments[1];
}

$choices = explode(",", $choices);
$rattings = [];
$longest  = 0;
$lucky    = false;

foreach ($choices as $choice) {
	do {
		$score = rand(0, 100000);
    if (!$lucky) $lucky = rand(0, 1);
    if ($lucky === 1) { $score = $score * 2; }
	} while(isset($rattings[$score]));
	if (strlen($score) > $longest) $longest = strlen($score);
	$rattings[$score] = trim($choice).($lucky===1?'*':'');
  if ($lucky===1) $lucky = -1;
}

krsort($rattings);

echo "\nYour results:\n";
foreach ($rattings as $score => $label)
{
	echo "  ".str_pad($score, $longest). " ... {$label}\n";
}

