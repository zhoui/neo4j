#
# Copyright (c) 2002-2018 "Neo4j,"
# Neo4j Sweden AB [http://neo4j.com]
#
# This file is part of Neo4j Enterprise Edition. The included source
# code can be redistributed and/or modified under the terms of the
# GNU AFFERO GENERAL PUBLIC LICENSE Version 3
# (http://www.fsf.org/licensing/licenses/agpl-3.0.html) with the
# Commons Clause, as found in the associated LICENSE.txt file.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# Neo4j object code can be licensed independently from the source
# under separate terms from the AGPL. Inquiries can be directed to:
# licensing@neo4j.com
#
# More information is also available at:
# https://neo4j.com/licensing/
#

Feature: TemporalCreateAcceptance

  Scenario Outline: Should construct week date
    Given any graph
    When executing query:
    """
    RETURN date(<map>) AS d
    """
    Then the result should be:
      | d        |
      | <result> |
    Examples:
      | map                                               | result       |
      | {year:1816,week:1}                                | '1816-01-01' |
      | {year:1816,week:52}                               | '1816-12-23' |
      | {year:1817,week:1}                                | '1816-12-30' |
      | {year:1817,week:10}                               | '1817-03-03' |
      | {year:1817,week:30}                               | '1817-07-21' |
      | {year:1817,week:52}                               | '1817-12-22' |
      | {year:1818,week:1}                                | '1817-12-29' |
      | {year:1818,week:52}                               | '1818-12-21' |
      | {year:1818,week:53}                               | '1818-12-28' |
      | {year:1819,week:1}                                | '1819-01-04' |
      | {year:1819,week:52}                               | '1819-12-27' |
      | {dayOfWeek: 2, year: 1817, week: 1}               | '1816-12-31' |
      | {date: date('1816-12-30'), week: 2, dayOfWeek: 3} | '1817-01-08' |
      | {date: date('1816-12-31'), week: 2}               | '1817-01-07' |
      | {date: date('1816-12-31'), year: 1817, week: 2}   | '1817-01-07' |

  Scenario Outline: Should construct week localdatetime
    Given any graph
    When executing query:
    """
    RETURN localdatetime(<map>) AS d
    """
    Then the result should be:
      | d        |
      | <result> |
    Examples:
      | map                                               | result             |
      | {year:1816,week:1}                                | '1816-01-01T00:00' |
      | {year:1816,week:52}                               | '1816-12-23T00:00' |
      | {year:1817,week:1}                                | '1816-12-30T00:00' |
      | {year:1817,week:10}                               | '1817-03-03T00:00' |
      | {year:1817,week:30}                               | '1817-07-21T00:00' |
      | {year:1817,week:52}                               | '1817-12-22T00:00' |
      | {year:1818,week:1}                                | '1817-12-29T00:00' |
      | {year:1818,week:52}                               | '1818-12-21T00:00' |
      | {year:1818,week:53}                               | '1818-12-28T00:00' |
      | {year:1819,week:1}                                | '1819-01-04T00:00' |
      | {year:1819,week:52}                               | '1819-12-27T00:00' |
      | {dayOfWeek: 2, year: 1817, week: 1}               | '1816-12-31T00:00' |
      | {date: date('1816-12-30'), week: 2, dayOfWeek: 3} | '1817-01-08T00:00' |
      | {date: date('1816-12-31'), week: 2}               | '1817-01-07T00:00' |
      | {date: date('1816-12-31'), year: 1817, week: 2}   | '1817-01-07T00:00' |

  Scenario Outline: Should construct week datetime
    Given any graph
    When executing query:
    """
    RETURN datetime(<map>) AS d
    """
    Then the result should be:
      | d        |
      | <result> |
    Examples:
      | map                                               | result              |
      | {year:1816,week:1}                                | '1816-01-01T00:00Z' |
      | {year:1816,week:52}                               | '1816-12-23T00:00Z' |
      | {year:1817,week:1}                                | '1816-12-30T00:00Z' |
      | {year:1817,week:10}                               | '1817-03-03T00:00Z' |
      | {year:1817,week:30}                               | '1817-07-21T00:00Z' |
      | {year:1817,week:52}                               | '1817-12-22T00:00Z' |
      | {year:1818,week:1}                                | '1817-12-29T00:00Z' |
      | {year:1818,week:52}                               | '1818-12-21T00:00Z' |
      | {year:1818,week:53}                               | '1818-12-28T00:00Z' |
      | {year:1819,week:1}                                | '1819-01-04T00:00Z' |
      | {year:1819,week:52}                               | '1819-12-27T00:00Z' |
      | {dayOfWeek: 2, year: 1817, week: 1}               | '1816-12-31T00:00Z' |
      | {date: date('1816-12-30'), week: 2, dayOfWeek: 3} | '1817-01-08T00:00Z' |
      | {date: date('1816-12-31'), week: 2}               | '1817-01-07T00:00Z' |
      | {date: date('1816-12-31'), year: 1817, week: 2}   | '1817-01-07T00:00Z' |

  Scenario: Should construct date
    Given an empty graph
    When executing query:
      """
      UNWIND [date({year:1984, month:10, day:11}),
              date({year:1984, month:10}),
              date({year:1984, week:10, dayOfWeek:3}),
              date({year:1984, week:10}),
              date({year:1984}),
              date({year:1984, ordinalDay:202}),
              date({year:1984, quarter:3, dayOfQuarter: 45}),
              date({year:1984, quarter:3})] as d
      RETURN d
      """
    Then the result should be, in order:
      | d            |
      | '1984-10-11' |
      | '1984-10-01' |
      | '1984-03-07' |
      | '1984-03-05' |
      | '1984-01-01' |
      | '1984-07-20' |
      | '1984-08-14' |
      | '1984-07-01' |
    And no side effects

  Scenario: Should construct local time
    Given an empty graph
    When executing query:
      """
      UNWIND [localtime({hour:12, minute:31, second:14, nanosecond: 789, millisecond: 123, microsecond: 456}),
              localtime({hour:12, minute:31, second:14, nanosecond: 645876123}),
              localtime({hour:12, minute:31, second:14, microsecond: 645876}),
              localtime({hour:12, minute:31, second:14, millisecond: 645}),
              localtime({hour:12, minute:31, second:14}),
              localtime({hour:12, minute:31}),
              localtime({hour:12})] as d
      RETURN d
      """
    Then the result should be, in order:
      | d                    |
      | '12:31:14.123456789' |
      | '12:31:14.645876123' |
      | '12:31:14.645876'    |
      | '12:31:14.645'       |
      | '12:31:14'           |
      | '12:31'              |
      | '12:00'              |
    And no side effects

  Scenario: Should construct time
    Given an empty graph
    When executing query:
      """
      UNWIND [time({hour:12, minute:31, second:14, nanosecond: 789, millisecond: 123, microsecond: 456}),
              time({hour:12, minute:31, second:14, nanosecond: 645876123}),
              time({hour:12, minute:31, second:14, nanosecond: 3}),
              time({hour:12, minute:31, second:14, microsecond: 645876}),
              time({hour:12, minute:31, second:14, millisecond: 645}),
              time({hour:12, minute:31, second:14}),
              time({hour:12, minute:31}),
              time({hour:12}),
              time({hour:12, minute:31, second:14, nanosecond: 645876123, timezone: '+01:00'}),
              time({hour:12, minute:31, second:14, microsecond: 645876, timezone: '+01:00'}),
              time({hour:12, minute:31, second:14, millisecond: 645, timezone: '+01:00'}),
              time({hour:12, minute:31, second:14, timezone: '+01:00'}),
              time({hour:12, minute:31, timezone: '+01:00'}),
              time({hour:12, timezone: '+01:00'})] as d
      RETURN d
      """
    Then the result should be, in order:
      | d |
      | '12:31:14.123456789Z' |
      | '12:31:14.645876123Z' |
      | '12:31:14.000000003Z' |
      | '12:31:14.645876Z' |
      | '12:31:14.645Z' |
      | '12:31:14Z' |
      | '12:31Z' |
      | '12:00Z' |
      | '12:31:14.645876123+01:00' |
      | '12:31:14.645876+01:00' |
      | '12:31:14.645+01:00' |
      | '12:31:14+01:00' |
      | '12:31+01:00' |
      | '12:00+01:00' |
    And no side effects

  Scenario: Should construct local date time
    Given an empty graph
    When executing query:
      """
      UNWIND [localdatetime({year:1984, month:10, day:11, hour:12, minute:31, second:14, nanosecond: 789, millisecond: 123, microsecond: 456}),
              localdatetime({year:1984, month:10, day:11, hour:12, minute:31, second:14, nanosecond: 645876123}),
              localdatetime({year:1984, month:10, day:11, hour:12, minute:31, second:14, nanosecond: 3}),
              localdatetime({year:1984, month:10, day:11, hour:12, minute:31, second:14, microsecond: 645876}),
              localdatetime({year:1984, month:10, day:11, hour:12, minute:31, second:14, millisecond: 645}),
              localdatetime({year:1984, month:10, day:11, hour:12, minute:31, second:14}),
              localdatetime({year:1984, month:10, day:11, hour:12, minute:31}),
              localdatetime({year:1984, month:10, day:11, hour:12}),
              localdatetime({year:1984, month:10, day:11}),
              localdatetime({year:1984, week:10, dayOfWeek:3, hour:12, minute:31, second:14, nanosecond: 645876123}),
              localdatetime({year:1984, week:10, dayOfWeek:3, hour:12, minute:31, second:14, microsecond: 645876}),
              localdatetime({year:1984, week:10, dayOfWeek:3, hour:12, minute:31, second:14, millisecond: 645}),
              localdatetime({year:1984, week:10, dayOfWeek:3, hour:12, minute:31, second:14}),
              localdatetime({year:1984, week:10, dayOfWeek:3, hour:12, minute:31}),
              localdatetime({year:1984, week:10, dayOfWeek:3, hour:12}),
              localdatetime({year:1984, week:10, dayOfWeek:3}),
              localdatetime({year:1984, ordinalDay:202, hour:12, minute:31, second:14, nanosecond: 645876123}),
              localdatetime({year:1984, ordinalDay:202, hour:12, minute:31, second:14, microsecond: 645876}),
              localdatetime({year:1984, ordinalDay:202, hour:12, minute:31, second:14, millisecond: 645}),
              localdatetime({year:1984, ordinalDay:202, hour:12, minute:31, second:14}),
              localdatetime({year:1984, ordinalDay:202, hour:12, minute:31}),
              localdatetime({year:1984, ordinalDay:202, hour:12}),
              localdatetime({year:1984, ordinalDay:202}),
              localdatetime({year:1984, quarter:3, dayOfQuarter: 45, hour:12, minute:31, second:14, nanosecond: 645876123}),
              localdatetime({year:1984, quarter:3, dayOfQuarter: 45, hour:12, minute:31, second:14, microsecond: 645876}),
              localdatetime({year:1984, quarter:3, dayOfQuarter: 45, hour:12, minute:31, second:14, millisecond: 645}),
              localdatetime({year:1984, quarter:3, dayOfQuarter: 45, hour:12, minute:31, second:14}),
              localdatetime({year:1984, quarter:3, dayOfQuarter: 45, hour:12, minute:31}),
              localdatetime({year:1984, quarter:3, dayOfQuarter: 45, hour:12}),
              localdatetime({year:1984, quarter:3, dayOfQuarter: 45}),
              localdatetime({year:1984})] as d
      RETURN d
      """
    Then the result should be, in order:
      | d |
      | '1984-10-11T12:31:14.123456789' |
      | '1984-10-11T12:31:14.645876123' |
      | '1984-10-11T12:31:14.000000003' |
      | '1984-10-11T12:31:14.645876' |
      | '1984-10-11T12:31:14.645' |
      | '1984-10-11T12:31:14' |
      | '1984-10-11T12:31' |
      | '1984-10-11T12:00' |
      | '1984-10-11T00:00' |
      | '1984-03-07T12:31:14.645876123' |
      | '1984-03-07T12:31:14.645876' |
      | '1984-03-07T12:31:14.645' |
      | '1984-03-07T12:31:14' |
      | '1984-03-07T12:31' |
      | '1984-03-07T12:00' |
      | '1984-03-07T00:00' |
      | '1984-07-20T12:31:14.645876123' |
      | '1984-07-20T12:31:14.645876' |
      | '1984-07-20T12:31:14.645' |
      | '1984-07-20T12:31:14' |
      | '1984-07-20T12:31' |
      | '1984-07-20T12:00' |
      | '1984-07-20T00:00' |
      | '1984-08-14T12:31:14.645876123' |
      | '1984-08-14T12:31:14.645876' |
      | '1984-08-14T12:31:14.645' |
      | '1984-08-14T12:31:14' |
      | '1984-08-14T12:31' |
      | '1984-08-14T12:00' |
      | '1984-08-14T00:00' |
      | '1984-01-01T00:00' |
    And no side effects

  Scenario: Should construct date time
    Given an empty graph
    When executing query:
      """
      UNWIND [datetime({year:1984, month:10, day:11, hour:12, minute:31, second:14, nanosecond: 789, millisecond: 123, microsecond: 456}),
              datetime({year:1984, month:10, day:11, hour:12, minute:31, second:14, nanosecond: 645876123}),
              datetime({year:1984, month:10, day:11, hour:12, minute:31, second:14, microsecond: 645876}),
              datetime({year:1984, month:10, day:11, hour:12, minute:31, second:14, millisecond: 645}),
              datetime({year:1984, month:10, day:11, hour:12, minute:31, second:14}),
              datetime({year:1984, month:10, day:11, hour:12, minute:31}),
              datetime({year:1984, month:10, day:11, hour:12}),
              datetime({year:1984, month:10, day:11}),
              datetime({year:1984, week:10, dayOfWeek:3, hour:12, minute:31, second:14, nanosecond: 645876123}),
              datetime({year:1984, week:10, dayOfWeek:3, hour:12, minute:31, second:14, microsecond: 645876}),
              datetime({year:1984, week:10, dayOfWeek:3, hour:12, minute:31, second:14, millisecond: 645}),
              datetime({year:1984, week:10, dayOfWeek:3, hour:12, minute:31, second:14}),
              datetime({year:1984, week:10, dayOfWeek:3, hour:12, minute:31}),
              datetime({year:1984, week:10, dayOfWeek:3, hour:12}),
              datetime({year:1984, week:10, dayOfWeek:3}),
              datetime({year:1984, ordinalDay:202, hour:12, minute:31, second:14, nanosecond: 645876123}),
              datetime({year:1984, ordinalDay:202, hour:12, minute:31, second:14, microsecond: 645876}),
              datetime({year:1984, ordinalDay:202, hour:12, minute:31, second:14, millisecond: 645}),
              datetime({year:1984, ordinalDay:202, hour:12, minute:31, second:14}),
              datetime({year:1984, ordinalDay:202, hour:12, minute:31}),
              datetime({year:1984, ordinalDay:202, hour:12}),
              datetime({year:1984, ordinalDay:202}),
              datetime({year:1984, quarter:3, dayOfQuarter: 45, hour:12, minute:31, second:14, nanosecond: 645876123}),
              datetime({year:1984, quarter:3, dayOfQuarter: 45, hour:12, minute:31, second:14, microsecond: 645876}),
              datetime({year:1984, quarter:3, dayOfQuarter: 45, hour:12, minute:31, second:14, millisecond: 645}),
              datetime({year:1984, quarter:3, dayOfQuarter: 45, hour:12, minute:31, second:14}),
              datetime({year:1984, quarter:3, dayOfQuarter: 45, hour:12, minute:31}),
              datetime({year:1984, quarter:3, dayOfQuarter: 45, hour:12}),
              datetime({year:1984, quarter:3, dayOfQuarter: 45}),
              datetime({year:1984}),

              datetime({year:1984, month:10, day:11, hour:12, minute:31, second:14, nanosecond: 645876123, timezone: '+01:00'}),
              datetime({year:1984, month:10, day:11, hour:12, minute:31, second:14, microsecond: 645876, timezone: '+01:00'}),
              datetime({year:1984, month:10, day:11, hour:12, minute:31, second:14, millisecond: 645, timezone: '+01:00'}),
              datetime({year:1984, month:10, day:11, hour:12, minute:31, second:14, timezone: '+01:00'}),
              datetime({year:1984, month:10, day:11, hour:12, minute:31, timezone: '+01:00'}),
              datetime({year:1984, month:10, day:11, hour:12, timezone: '+01:00'}),
              datetime({year:1984, month:10, day:11, timezone: '+01:00'}),
              datetime({year:1984, week:10, dayOfWeek:3, hour:12, minute:31, second:14, nanosecond: 645876123, timezone: '+01:00'}),
              datetime({year:1984, week:10, dayOfWeek:3, hour:12, minute:31, second:14, microsecond: 645876, timezone: '+01:00'}),
              datetime({year:1984, week:10, dayOfWeek:3, hour:12, minute:31, second:14, millisecond: 645, timezone: '+01:00'}),
              datetime({year:1984, week:10, dayOfWeek:3, hour:12, minute:31, second:14, timezone: '+01:00'}),
              datetime({year:1984, week:10, dayOfWeek:3, hour:12, minute:31, timezone: '+01:00'}),
              datetime({year:1984, week:10, dayOfWeek:3, hour:12, timezone: '+01:00'}),
              datetime({year:1984, week:10, dayOfWeek:3, timezone: '+01:00'}),
              datetime({year:1984, ordinalDay:202, hour:12, minute:31, second:14, nanosecond: 645876123, timezone: '+01:00'}),
              datetime({year:1984, ordinalDay:202, hour:12, minute:31, second:14, microsecond: 645876, timezone: '+01:00'}),
              datetime({year:1984, ordinalDay:202, hour:12, minute:31, second:14, millisecond: 645, timezone: '+01:00'}),
              datetime({year:1984, ordinalDay:202, hour:12, minute:31, second:14, timezone: '+01:00'}),
              datetime({year:1984, ordinalDay:202, hour:12, minute:31, timezone: '+01:00'}),
              datetime({year:1984, ordinalDay:202, hour:12, timezone: '+01:00'}),
              datetime({year:1984, ordinalDay:202, timezone: '+01:00'}),
              datetime({year:1984, quarter:3, dayOfQuarter: 45, hour:12, minute:31, second:14, nanosecond: 645876123, timezone: '+01:00'}),
              datetime({year:1984, quarter:3, dayOfQuarter: 45, hour:12, minute:31, second:14, microsecond: 645876, timezone: '+01:00'}),
              datetime({year:1984, quarter:3, dayOfQuarter: 45, hour:12, minute:31, second:14, millisecond: 645, timezone: '+01:00'}),
              datetime({year:1984, quarter:3, dayOfQuarter: 45, hour:12, minute:31, second:14, timezone: '+01:00'}),
              datetime({year:1984, quarter:3, dayOfQuarter: 45, hour:12, minute:31, timezone: '+01:00'}),
              datetime({year:1984, quarter:3, dayOfQuarter: 45, hour:12, timezone: '+01:00'}),
              datetime({year:1984, quarter:3, dayOfQuarter: 45, timezone: '+01:00'}),
              datetime({year:1984, timezone: '+01:00'}),

              datetime({year:1984, month:10, day:11, hour:12, minute:31, second:14, nanosecond: 645876123, timezone: 'Europe/Stockholm'}),
              datetime({year:1984, month:10, day:11, hour:12, minute:31, second:14, microsecond: 645876, timezone: 'Europe/Stockholm'}),
              datetime({year:1984, month:10, day:11, hour:12, minute:31, second:14, millisecond: 645, timezone: 'Europe/Stockholm'}),
              datetime({year:1984, month:10, day:11, hour:12, minute:31, second:14, timezone: 'Europe/Stockholm'}),
              datetime({year:1984, month:10, day:11, hour:12, minute:31, timezone: 'Europe/Stockholm'}),
              datetime({year:1984, month:10, day:11, hour:12, timezone: 'Europe/Stockholm'}),
              datetime({year:1984, month:10, day:11, timezone: 'Europe/Stockholm'}),
              datetime({year:1984, week:10, dayOfWeek:3, hour:12, minute:31, second:14, nanosecond: 645876123, timezone: 'Europe/Stockholm'}),
              datetime({year:1984, week:10, dayOfWeek:3, hour:12, minute:31, second:14, microsecond: 645876, timezone: 'Europe/Stockholm'}),
              datetime({year:1984, week:10, dayOfWeek:3, hour:12, minute:31, second:14, millisecond: 645, timezone: 'Europe/Stockholm'}),
              datetime({year:1984, week:10, dayOfWeek:3, hour:12, minute:31, second:14, timezone: 'Europe/Stockholm'}),
              datetime({year:1984, week:10, dayOfWeek:3, hour:12, minute:31, timezone: 'Europe/Stockholm'}),
              datetime({year:1984, week:10, dayOfWeek:3, hour:12, timezone: 'Europe/Stockholm'}),
              datetime({year:1984, week:10, dayOfWeek:3, timezone: 'Europe/Stockholm'}),
              datetime({year:1984, ordinalDay:202, hour:12, minute:31, second:14, nanosecond: 645876123, timezone: 'Europe/Stockholm'}),
              datetime({year:1984, ordinalDay:202, hour:12, minute:31, second:14, microsecond: 645876, timezone: 'Europe/Stockholm'}),
              datetime({year:1984, ordinalDay:202, hour:12, minute:31, second:14, millisecond: 645, timezone: 'Europe/Stockholm'}),
              datetime({year:1984, ordinalDay:202, hour:12, minute:31, second:14, timezone: 'Europe/Stockholm'}),
              datetime({year:1984, ordinalDay:202, hour:12, minute:31, timezone: 'Europe/Stockholm'}),
              datetime({year:1984, ordinalDay:202, hour:12, timezone: 'Europe/Stockholm'}),
              datetime({year:1984, ordinalDay:202, timezone: 'Europe/Stockholm'}),
              datetime({year:1984, quarter:3, dayOfQuarter: 45, hour:12, minute:31, second:14, nanosecond: 645876123, timezone: 'Europe/Stockholm'}),
              datetime({year:1984, quarter:3, dayOfQuarter: 45, hour:12, minute:31, second:14, microsecond: 645876, timezone: 'Europe/Stockholm'}),
              datetime({year:1984, quarter:3, dayOfQuarter: 45, hour:12, minute:31, second:14, millisecond: 645, timezone: 'Europe/Stockholm'}),
              datetime({year:1984, quarter:3, dayOfQuarter: 45, hour:12, minute:31, second:14, timezone: 'Europe/Stockholm'}),
              datetime({year:1984, quarter:3, dayOfQuarter: 45, hour:12, minute:31, timezone: 'Europe/Stockholm'}),
              datetime({year:1984, quarter:3, dayOfQuarter: 45, hour:12, timezone: 'Europe/Stockholm'}),
              datetime({year:1984, quarter:3, dayOfQuarter: 45, timezone: 'Europe/Stockholm'}),
              datetime({year:1984, timezone: 'Europe/Stockholm'}),

              datetime.fromepoch(416779,999999999),
              datetime.fromepochmillis(237821673987)] as d
      RETURN d
      """
    Then the result should be, in order:
      | d |
      | '1984-10-11T12:31:14.123456789Z' |
      | '1984-10-11T12:31:14.645876123Z' |
      | '1984-10-11T12:31:14.645876Z' |
      | '1984-10-11T12:31:14.645Z' |
      | '1984-10-11T12:31:14Z' |
      | '1984-10-11T12:31Z' |
      | '1984-10-11T12:00Z' |
      | '1984-10-11T00:00Z' |
      | '1984-03-07T12:31:14.645876123Z' |
      | '1984-03-07T12:31:14.645876Z' |
      | '1984-03-07T12:31:14.645Z' |
      | '1984-03-07T12:31:14Z' |
      | '1984-03-07T12:31Z' |
      | '1984-03-07T12:00Z' |
      | '1984-03-07T00:00Z' |
      | '1984-07-20T12:31:14.645876123Z' |
      | '1984-07-20T12:31:14.645876Z' |
      | '1984-07-20T12:31:14.645Z' |
      | '1984-07-20T12:31:14Z' |
      | '1984-07-20T12:31Z' |
      | '1984-07-20T12:00Z' |
      | '1984-07-20T00:00Z' |
      | '1984-08-14T12:31:14.645876123Z' |
      | '1984-08-14T12:31:14.645876Z' |
      | '1984-08-14T12:31:14.645Z' |
      | '1984-08-14T12:31:14Z' |
      | '1984-08-14T12:31Z' |
      | '1984-08-14T12:00Z' |
      | '1984-08-14T00:00Z' |
      | '1984-01-01T00:00Z' |
      | '1984-10-11T12:31:14.645876123+01:00' |
      | '1984-10-11T12:31:14.645876+01:00' |
      | '1984-10-11T12:31:14.645+01:00' |
      | '1984-10-11T12:31:14+01:00' |
      | '1984-10-11T12:31+01:00' |
      | '1984-10-11T12:00+01:00' |
      | '1984-10-11T00:00+01:00' |
      | '1984-03-07T12:31:14.645876123+01:00' |
      | '1984-03-07T12:31:14.645876+01:00' |
      | '1984-03-07T12:31:14.645+01:00' |
      | '1984-03-07T12:31:14+01:00' |
      | '1984-03-07T12:31+01:00' |
      | '1984-03-07T12:00+01:00' |
      | '1984-03-07T00:00+01:00' |
      | '1984-07-20T12:31:14.645876123+01:00' |
      | '1984-07-20T12:31:14.645876+01:00' |
      | '1984-07-20T12:31:14.645+01:00' |
      | '1984-07-20T12:31:14+01:00' |
      | '1984-07-20T12:31+01:00' |
      | '1984-07-20T12:00+01:00' |
      | '1984-07-20T00:00+01:00' |
      | '1984-08-14T12:31:14.645876123+01:00' |
      | '1984-08-14T12:31:14.645876+01:00' |
      | '1984-08-14T12:31:14.645+01:00' |
      | '1984-08-14T12:31:14+01:00' |
      | '1984-08-14T12:31+01:00' |
      | '1984-08-14T12:00+01:00' |
      | '1984-08-14T00:00+01:00' |
      | '1984-01-01T00:00+01:00' |
      | '1984-10-11T12:31:14.645876123+01:00[Europe/Stockholm]' |
      | '1984-10-11T12:31:14.645876+01:00[Europe/Stockholm]' |
      | '1984-10-11T12:31:14.645+01:00[Europe/Stockholm]' |
      | '1984-10-11T12:31:14+01:00[Europe/Stockholm]' |
      | '1984-10-11T12:31+01:00[Europe/Stockholm]' |
      | '1984-10-11T12:00+01:00[Europe/Stockholm]' |
      | '1984-10-11T00:00+01:00[Europe/Stockholm]' |
      | '1984-03-07T12:31:14.645876123+01:00[Europe/Stockholm]' |
      | '1984-03-07T12:31:14.645876+01:00[Europe/Stockholm]' |
      | '1984-03-07T12:31:14.645+01:00[Europe/Stockholm]' |
      | '1984-03-07T12:31:14+01:00[Europe/Stockholm]' |
      | '1984-03-07T12:31+01:00[Europe/Stockholm]' |
      | '1984-03-07T12:00+01:00[Europe/Stockholm]' |
      | '1984-03-07T00:00+01:00[Europe/Stockholm]' |
      | '1984-07-20T12:31:14.645876123+02:00[Europe/Stockholm]' |
      | '1984-07-20T12:31:14.645876+02:00[Europe/Stockholm]' |
      | '1984-07-20T12:31:14.645+02:00[Europe/Stockholm]' |
      | '1984-07-20T12:31:14+02:00[Europe/Stockholm]' |
      | '1984-07-20T12:31+02:00[Europe/Stockholm]' |
      | '1984-07-20T12:00+02:00[Europe/Stockholm]' |
      | '1984-07-20T00:00+02:00[Europe/Stockholm]' |
      | '1984-08-14T12:31:14.645876123+02:00[Europe/Stockholm]' |
      | '1984-08-14T12:31:14.645876+02:00[Europe/Stockholm]' |
      | '1984-08-14T12:31:14.645+02:00[Europe/Stockholm]' |
      | '1984-08-14T12:31:14+02:00[Europe/Stockholm]' |
      | '1984-08-14T12:31+02:00[Europe/Stockholm]' |
      | '1984-08-14T12:00+02:00[Europe/Stockholm]' |
      | '1984-08-14T00:00+02:00[Europe/Stockholm]' |
      | '1984-01-01T00:00+01:00[Europe/Stockholm]' |
      | '1970-01-05T19:46:19.999999999Z' |
      | '1977-07-15T13:34:33.987Z' |

    And no side effects

  Scenario: Should construct duration
    Given an empty graph
    When executing query:
      """
      UNWIND [duration({days: 14, hours:16, minutes: 12}),
              duration({months: 5, days: 1.5}),
              duration({months: 0.75}),
              duration({weeks: 2.5}),
              duration({years: 12, months:5, days: 14, hours:16, minutes: 12, seconds: 70}),
              duration({days: 14, seconds: 70, milliseconds: 1}),
              duration({days: 14, seconds: 70, microseconds: 1}),
              duration({days: 14, seconds: 70, nanoseconds: 1}),
              duration({minutes: 1.5, seconds: 1})] as d
      RETURN d
      """
    Then the result should be, in order:
      | d |
      | 'P14DT16H12M' |
      | 'P5M1DT12H' |
      | 'P22DT19H51M49.5S' |
      | 'P17DT12H' |
      | 'P12Y5M14DT16H13M10S' |
      | 'P14DT1M10.001S' |
      | 'P14DT1M10.000001S' |
      | 'P14DT1M10.000000001S' |
      | 'PT1M31S' |
    And no side effects

  Scenario: Should construct temporal with time offset with second precision
    Given an empty graph
    When executing query:
      """
      UNWIND [ time({hour: 12, minute: 34, second: 56, timezone:'+02:05:00'}),
               time({hour: 12, minute: 34, second: 56, timezone:'+02:05:59'}),
               time({hour: 12, minute: 34, second: 56, timezone:'-02:05:07'}),
               datetime({year: 1984, month: 10, day: 11, hour: 12, minute: 34, second: 56, timezone:'+02:05:59'})
             ] as d
      RETURN d
      """
    Then the result should be, in order:
      | d                              |
      | '12:34:56+02:05'               |
      | '12:34:56+02:05:59'            |
      | '12:34:56-02:05:07'            |
      | '1984-10-11T12:34:56+02:05:59' |

    And no side effects

  Scenario: Should store date
    Given an empty graph
    When executing query:
    """
      UNWIND [date({year:1984, month:10, day:11}),
              [date({year:1984, month:10, day:12})],
              [date({year:1984, month:10, day:13}), date({year:1984, month:10, day:14}), date({year:1984, month:10, day:15})]
              ] as d
      CREATE ({p:d})
      RETURN count(*) AS count
      """
    Then the result should be, in order:
      | count |
      | 3 |
    And the side effects should be:
      | +nodes      | 3 |
      | +properties | 3 |

  Scenario: Should store local time
    Given an empty graph
    When executing query:
    """
      UNWIND [localtime({hour:12}),
              [localtime({hour:13})],
              [localtime({hour:14}), localtime({hour:15}), localtime({hour:16})]
              ] as t
      CREATE ({p:t})
      RETURN count(*) AS count
      """
    Then the result should be, in order:
      | count |
      | 3 |
    And the side effects should be:
      | +nodes      | 3 |
      | +properties | 3 |

  Scenario: Should store time
    Given an empty graph
    When executing query:
    """
      UNWIND [time({hour:12}),
              [time({hour:13})],
              [time({hour:14}), time({hour:15}), time({hour:16})]
              ] as t
      CREATE ({p:t})
      RETURN count(*) AS count
      """
    Then the result should be, in order:
      | count |
      | 3 |
    And the side effects should be:
      | +nodes      | 3 |
      | +properties | 3 |

  Scenario: Should store local date time
    Given an empty graph
    When executing query:
    """
      UNWIND [localdatetime({year:1912}),
              [localdatetime({year:1913})],
              [localdatetime({year:1914}), localdatetime({year:1915}), localdatetime({year:1916})]
              ] as dt
      CREATE ({p:dt})
      RETURN count(*) AS count
      """
    Then the result should be, in order:
      | count |
      | 3 |
    And the side effects should be:
      | +nodes      | 3 |
      | +properties | 3 |

  Scenario: Should store date time
    Given an empty graph
    When executing query:
    """
      UNWIND [datetime({year:1912}),
              [datetime({year:1913})],
              [datetime({year:1914}), datetime({year:1915}), datetime({year:1916})]
              ] as dt
      CREATE ({p:dt})
      RETURN count(*) AS count
      """
    Then the result should be, in order:
      | count |
      | 3 |
    And the side effects should be:
      | +nodes      | 3 |
      | +properties | 3 |

  Scenario: Should store duration
    Given an empty graph
    When executing query:
    """
      UNWIND [duration({seconds:12}),
              [duration({seconds:13})],
              [duration({seconds:14}), duration({seconds:15}), duration({seconds:16})]
              ] as duration
      CREATE ({p:duration})
      RETURN count(*) AS count
      """
    Then the result should be, in order:
      | count |
      | 3 |
    And the side effects should be:
      | +nodes      | 3 |
      | +properties | 3 |

