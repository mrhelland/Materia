<?php
// all files in heroku/config are copied to config/production on heroku
// they will overwrite any files already in config/production
return [
	'log_threshold'    => Fuel::L_DEBUG,
	# send logs via STDOUT for heroku
	'log_handler_factory'   => function($locals, $level){ return new \Monolog\Handler\ErrorLogHandler(); },
	
	'widgets' => [
		[
			'id' => 1,
			'package'  => 'https://github.com/ucfopen/crossword-materia-widget/releases/download/v1.3.0/crossword.wigt',
			'checksum' => 'https://github.com/ucfopen/crossword-materia-widget/releases/download/v1.3.0/crossword-build-info.yml',
		],
		[
			'id' => 2,
			'package'  => 'https://github.com/ucfopen/hangman-materia-widget/releases/download/v1.1.3/hangman.wigt',
			'checksum' => 'https://github.com/ucfopen/hangman-materia-widget/releases/download/v1.1.3/hangman-build-info.yml',
		],
		[
			'id' => 3,
			'package'  => 'https://github.com/ucfopen/matching-materia-widget/releases/download/v1.1.5/matching.wigt',
			'checksum' => 'https://github.com/ucfopen/matching-materia-widget/releases/download/v1.1.5/matching-build-info.yml',
		],
		[
			'id' => 4,
			'package'  => 'https://github.com/ucfopen/enigma-materia-widget/releases/download/v2.1.3/enigma.wigt',
			'checksum' => 'https://github.com/ucfopen/enigma-materia-widget/releases/download/v2.1.3/enigma-build-info.yml',
		],
		[
			'id' => 5,
			'package'  => 'https://github.com/ucfopen/labeling-materia-widget/releases/download/v1.0.4/labeling.wigt',
			'checksum' => 'https://github.com/ucfopen/labeling-materia-widget/releases/download/v1.0.4/labeling-build-info.yml',
		],
		[
			'id' => 6,
			'package' => 'https://github.com/ucfopen/flash-cards-materia-widget/releases/download/v1.1.3/flash-cards.wigt',
			'checksum' => 'https://github.com/ucfopen/flash-cards-materia-widget/releases/download/v1.1.3/flash-cards-build-info.yml'
		],
		[
			'id' => 7,
			'package' => 'https://github.com/ucfopen/this-or-that-materia-widget/releases/download/v1.0.9/this-or-that.wigt',
			'checksum' => 'https://github.com/ucfopen/this-or-that-materia-widget/releases/download/v1.0.9/this-or-that-build-info.yml'
		],
		[
			'id' => 8,
			'package' => 'https://github.com/ucfopen/word-search-materia-widget/releases/download/v1.1.5/word-search.wigt',
			'checksum' => 'https://github.com/ucfopen/word-search-materia-widget/releases/download/v1.1.5/word-search-build-info.yml'
		],
		[
			'id' => 9,
			'package' => 'https://github.com/ucfopen/adventure-materia-widget/releases/download/v2.2.1/adventure.wigt',
			'checksum' => 'https://github.com/ucfopen/adventure-materia-widget/releases/download/v2.2.1/adventure-build-info.yml'
		],
		[
			'id' => 10,
			'package' => 'https://github.com/ucfopen/equation-sandbox-materia-widget/releases/download/v2.0.3/equation-sandbox.wigt',
			'checksum' => 'https://github.com/ucfopen/equation-sandbox-materia-widget/releases/download/v2.0.3/equation-sandbox-build-info.yml'
		],
		[
			'id' => 11,
			'package' => 'https://github.com/ucfopen/sort-it-out-materia-widget/releases/download/v1.0.6/sort-it-out.wigt',
			'checksum' => 'https://github.com/ucfopen/sort-it-out-materia-widget/releases/download/v1.0.6/sort-it-out-build-info.yml'
		],
		[
			'id' => 12,
			'package' => 'https://github.com/ucfopen/survey-materia-widget/releases/download/v1.1.0/simple-survey.wigt',
			'checksum' => 'https://github.com/ucfopen/survey-materia-widget/releases/download/v1.1.0/simple-survey-build-info.yml'
		],
	],


];
