# YamOverflow

This service polls the StackOverflow Search API for questions with configured tags and posts those questions to Yammer.

## Service flow

1) Polls StackOverflow /search API for tagged questions
2) Matches those questions against entries in database
3) If no record is found in database:
    a) Insert record to database
    b) Post question to group on Yammer
