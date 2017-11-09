defmodule ExAws.CloudWatch do
  @moduledoc """
  Operations on 

  """
  use ExAws.Utils,
    format_type: :xml,
    non_standard_keys: %{}
  #version of the AWS API
  @version "2015-12-01"

  @type param :: {key :: atom, value :: binary}
  @type dimension :: {name :: binary, value :: binary}
  @type action :: [
          type: binary,
          target_group_arn: binary
        ]

  @type certificate :: [
          certificate_arn: binary,
          is_default: boolean
        ]

  @type target_description :: [
          id: binary,
          port: integer,
          availability_zone: binary
        ]

  @type rule_condition :: [
          field: binary,
          values: [binary, ...]
        ]

  @type subnet_mapping :: [
          subnet_id: binary,
          allocation_id: binary
        ]
  @doc """
  Adds the specified certificate to the specified secure listener.

  If the certificate was already added, the call is successful but the certificate 
  is not added again.

  To list the certificates for your listener, use `describe_listener_certificates/1`.
  To remove certificates from your listener, use `remove_listener_certificates/1`.

  ## Examples:

        iex> ExAws.CloudWatch.add_listener_certificates(
        ...> "listener_arn", 
        ...>  [%{certificate_arn: "certificate1_arn", is_default: true}, 
        ...>   %{certificate_arn: "certificate2_arn"}])
        %ExAws.Operation.Query{action: :add_listener_certificates,
        params: %{"Action" => "AddListenerCertificates", 
        "Certificate.1.CertificateArn" => "certificate1_arn",
        "Certificate.1.IsDefault" => true,
        "Certificate.2.CertificateArn" => "certificate2_arn",
        "ListenerArn" => "listener_arn",
        "Version" => "2015-12-01"}, 
        parser: &ExAws.Utils.identity/2, path: "/", service: :elasticloadbalancing}

  """
  @spec add_listener_certificates(listener_arn :: binary, certificates :: [certificate, ...]) ::
          ExAws.Operation.Query.t()
  def add_listener_certificates(listener_arn, certificates, opts \\ []) do
    [
      {:listener_arn, listener_arn}, 
      {:certificates, certificates} | opts]
    |> build_request(:add_listener_certificates)
  end

  @doc """
  Check if an operation can be paginated

  Parameters 
    operation_name (string) -- The operation name. This is the same name as the method name on the client. For example, if the method name is create_foo, and you'd normally invoke the operation as client.create_foo(**kwargs), if the create_foo operation can be paginated, you can use the call client.get_paginator("create_foo").
  Returns
    True if the operation can be paginated, False otherwise.
  
  ## Examples:


  """
  @spec can_paginate(operation_name :: binary) :: ExAws.Operation.Query.t()
  def can_paginate(operation_name) do
    [{:operation_name, operation_name}]
    |> build_request(:can_paginate)
  end

  @doc """
  Deletes the specified alarms. In the event of an error, no alarms are deleted.
  Parameters
    AlarmNames (list) --
    [REQUIRED]

    The alarms to be deleted.
  Returns
    None
  
  ## Examples:

  """
  @spec delete_alarms(alarm_names :: [binary, ...]) :: ExAws.Operation.Query.t()
  def delete_alarms(alarm_names) :: ExAws.Operation.Query.t()
    [{:alarm_names, alarm_names}]
    |> build_request(:delete_alarms)
  end

  @doc """
  Deletes all dashboards that you specify. You may specify up to 100 dashboards to delete. If there is an error during this call, no dashboards are deleted.
  Parameters
    DashboardNames (list) --
      The dashboards to be deleted.

      (string) --
  Return type
    dict
  """
  @spec delete_dashboards(dashboard_names :: [binary, ...]) :: ExAws.Operation.Query.t()
  def delete_dashboards(dashboard_names) do
    [{:dashboard_names, dashboard_names}]
    |> build_request(:delete_dashboards)
  end

  @doc """
  Retrieves the history for the specified alarm. You can filter the results by date range or item type. If an alarm name is not specified, the histories for all alarms are returned.

  CloudWatch retains the history of an alarm even if you delete the alarm.  

  Parameters
    AlarmName (string) -- The name of the alarm.
    HistoryItemType (string) -- The type of alarm histories to retrieve.
    StartDate (datetime) -- The starting date to retrieve alarm history.
    EndDate (datetime) -- The ending date to retrieve alarm history.
    MaxRecords (integer) -- The maximum number of alarm history records to retrieve.
    NextToken (string) -- The token returned by a previous call to indicate that there is more data available.
  Return type
    dict
  """
  @type describe_alarm_history_opts :: [
    alarm_name: binary,
    history_item_type: binary,
    start_date: %DateTime,
    end_date: %DateTime,
    max_records: integer,
    next_token: binary
  ]
  @spec describe_alarm_history() :: ExAws.Operation.Query.t()
  @spec describe_alarm_history(opts :: describe_alarm_history_opts) :: ExAws.Operation.Query.t()
  def describe_alarm_history(opts \\ []) do
    opts |> build_request(:describe_alarm_history)
  end

  @doc """
  Retrieves the specified alarms. If no alarms are specified, all alarms are returned. Alarms can be retrieved by using only a prefix for the alarm name, the alarm state, or a prefix for any action.
  Parameters
    AlarmNames (list) --
      The names of the alarms.

      (string) --
    AlarmNamePrefix (string) -- The alarm name prefix. If this parameter is specified, you cannot specify AlarmNames .
    StateValue (string) -- The state value to be used in matching alarms.
    ActionPrefix (string) -- The action name prefix.
    MaxRecords (integer) -- The maximum number of alarm descriptions to retrieve.
    NextToken (string) -- The token returned by a previous call to indicate that there is more data available.
  Return type
    dict
  """
  @type describe_alarm_opts :: [
    alarm_names: [binary, ...],
    alarm_name_prefix: binary,
    state_value: binary,
    action_prefix: binary,
    max_records: integer,
    next_token: binary
  ]
  @spec describe_alarms() :: ExAws.Operation.Query.t()
  @spec desribe_alarms(ops :: describe_alarm_opts) :: ExAws.Operation.Query.t()
  def describe_alarms(opts \\ []) do
    opts |> build_request(:describe_alarms)
  end

  @doc """
  Retrieves the alarms for the specified metric. To filter the results, specify a statistic, period, or unit.
  Parameters
    MetricName (string) --
      [REQUIRED]

      The name of the metric.

    Namespace (string) --
      [REQUIRED]

      The namespace of the metric.

    Statistic (string) -- The statistic for the metric, other than percentiles. For percentile statistics, use ExtendedStatistics .
    ExtendedStatistic (string) -- The percentile statistic for the metric. Specify a value between p0.0 and p100.
    Dimensions (list) --
      The dimensions associated with the metric. If the metric has any associated dimensions, you must specify them in order for the call to succeed.

    (dict) --
      Expands the identity of a metric.

    Name (string) -- [REQUIRED]
      The name of the dimension.

    Value (string) -- [REQUIRED]
      The value representing the dimension measurement.

    Period (integer) -- The period, in seconds, over which the statistic is applied.
    Unit (string) -- The unit for the metric.
  Return type
      dict
  """
  @type describe_alarms_for_metric_opts :: [
    statistic: binary,
    extended_statistic: binary,
    dimensions: [dimension, ...],
    period: integer,
    unit: binary
  ]
  @spec describe_alarms_for_metric(
    metric_name :: binary,
    namespace :: binary
    ) :: ExAws.Operation.Query.t()
  @spec describe_alarms_for_metric(
    metric_name :: binary,
    namespace :: binary,
    opts :: describe_alarms_for_metric_opts
  ) :: ExAws.Operation.Query.t()
  def describe_alarms_for_metric(metric_name, namespace, opts \\ []) do
    [
      {:metric_name, metric_name},
      {:namespace, namespace} | opts
    ]
    |> build_request{:describe_alarms_for_metric}
  end

  @doc """
  Disables the actions for the specified alarms. When an alarm's actions are disabled, the alarm actions do not execute when the alarm state changes.
  Parameters
    AlarmNames (list) --
      [REQUIRED]

      The names of the alarms.

      (string) --
  Returns
    None
  """
  @spec disable_alarm_actions(alarm_names :: [binary, ...]) :: ExAws.Operation.Query.t()
  def disable_alarm_actions(alarm_names) do
    [{:alarm_names, alarm_names}]
    |> build_request(:disable_alarm_actions)
  end

  @doc """
  Enables the actions for the specified alarms.
  Parameters
    AlarmNames (list) --
      [REQUIRED]

      The names of the alarms.

      (string) --
  Returns
    None
  """
  @spec enable_alarm_actions(alarm_names :: [binary, ...]) :: ExAws.Operation.Query.t()
  def enable_alarm_actions(alarm_names) do
    [{:alarm_names, alarm_names}]
    |> build_request(:enable_alarm_actions)
  end

  @doc """
  Generate a presigned url given a client, its method, and arguments
  Parameters
    ClientMethod (string) -- The client method to presign for
    Params (dict) -- The parameters normally passed to ClientMethod.
    ExpiresIn (int) -- The number of seconds the presigned url is valid for. By default it expires in an hour (3600 seconds)
    HttpMethod (string) -- The http method to use on the generated url. By default, the http method is whatever is used in the method's model.
  Returns
    The presigned url
  """
  @type generate_presigned_url_opts :: [
    client_method: binary,
    params: [param, ...],
    expires_in: integer,
    http_method: binary
  ]
  @spec generate_presigned_url() :: ExAws.Operation.Query.t()
  @spec generate_presigned_url(opts :: generate_presigned_url_opts) :: ExAws.Operation.Query.t()
  def generate_presigned_url(opts \\ []) do
    opts |> build_request(:generate_presigned_url)
  end

  @doc """
  Displays the details of the dashboard that you specify.

  To copy an existing dashboard, use GetDashboard , and then use the data returned within DashboardBody as the template for the new dashboard when you call PutDashboard to create the copy.

  Parameters
    DashboardName (string) -- The name of the dashboard to be described.
  Return type
    dict
  """
  @type get_dashboard_opts :: [
    dashboard_name: binary
  ]
  @spec get_dashboard() :: ExAws.Operation.Query.t()
  @spec get_dashboard(opts :: get_dashboard_opts) :: ExAws.Operation.Query.t()
  def get_dashboard(opts \\ []) do
    opts |> build_request(:get_dashboard)
  end

  @doc """
  Gets statistics for the specified metric.

  The maximum number of data points returned from a single call is 1,440. If you request more than 1,440 data points, CloudWatch returns an error. To reduce the number of data points, you can narrow the specified time range and make multiple requests across adjacent time ranges, or you can increase the specified period. Data points are not returned in chronological order.

  CloudWatch aggregates data points based on the length of the period that you specify. For example, if you request statistics with a one-hour period, CloudWatch aggregates all data points with time stamps that fall within each one-hour period. Therefore, the number of values aggregated by CloudWatch is larger than the number of data points returned.

  CloudWatch needs raw data points to calculate percentile statistics. If you publish data using a statistic set instead, you can only retrieve percentile statistics for this data if one of the following conditions is true:

  The SampleCount value of the statistic set is 1.
  The Min and the Max values of the statistic set are equal.
  Amazon CloudWatch retains metric data as follows:

  Data points with a period of less than 60 seconds are available for 3 hours. These data points are high-resolution metrics and are available only for custom metrics that have been defined with a StorageResolution of 1.
  Data points with a period of 60 seconds (1-minute) are available for 15 days.
  Data points with a period of 300 seconds (5-minute) are available for 63 days.
  Data points with a period of 3600 seconds (1 hour) are available for 455 days (15 months).
  Data points that are initially published with a shorter period are aggregated together for long-term storage. For example, if you collect data using a period of 1 minute, the data remains available for 15 days with 1-minute resolution. After 15 days, this data is still available, but is aggregated and retrievable only with a resolution of 5 minutes. After 63 days, the data is further aggregated and is available with a resolution of 1 hour.

  CloudWatch started retaining 5-minute and 1-hour metric data as of July 9, 2016.

  Parameters
    Namespace (string) --
      [REQUIRED]

      The namespace of the metric, with or without spaces.

    MetricName (string) --
      [REQUIRED]

      The name of the metric, with or without spaces.

    Dimensions (list) --
      The dimensions. If the metric contains multiple dimensions, you must include a value for each dimension. CloudWatch treats each unique combination of dimensions as a separate metric. If a specific combination of dimensions was not published, you can't retrieve statistics for it. You must specify the same dimensions that were used when the metrics were created. For an example, see Dimension Combinations in the Amazon CloudWatch User Guide . For more information about specifying dimensions, see Publishing Metrics in the Amazon CloudWatch User Guide .

      (dict) --
      Expands the identity of a metric.

    Name (string) -- [REQUIRED]
      The name of the dimension.

    Value (string) -- [REQUIRED]
      The value representing the dimension measurement.

    StartTime (datetime) --
      [REQUIRED]

      The time stamp that determines the first data point to return. Start times are evaluated relative to the time that CloudWatch receives the request.

      The value specified is inclusive; results include data points with the specified time stamp. The time stamp must be in ISO 8601 UTC format (for example, 2016-10-03T23:00:00Z).

      CloudWatch rounds the specified time stamp as follows:

      Start time less than 15 days ago - Round down to the nearest whole minute. For example, 12:32:34 is rounded down to 12:32:00.
      Start time between 15 and 63 days ago - Round down to the nearest 5-minute clock interval. For example, 12:32:34 is rounded down to 12:30:00.
      Start time greater than 63 days ago - Round down to the nearest 1-hour clock interval. For example, 12:32:34 is rounded down to 12:00:00.
      If you set Period to 5, 10, or 30, the start time of your request is rounded down to the nearest time that corresponds to even 5-, 10-, or 30-second divisions of a minute. For example, if you make a query at (HH:mm:ss) 01:05:23 for the previous 10-second period, the start time of your request is rounded down and you receive data from 01:05:10 to 01:05:20. If you make a query at 15:07:17 for the previous 5 minutes of data, using a period of 5 seconds, you receive data timestamped between 15:02:15 and 15:07:15.

    EndTime (datetime) --
      [REQUIRED]

      The time stamp that determines the last data point to return.

      The value specified is exclusive; results include data points up to the specified time stamp. The time stamp must be in ISO 8601 UTC format (for example, 2016-10-10T23:00:00Z).

    Period (integer) --
      [REQUIRED]

      The granularity, in seconds, of the returned data points. For metrics with regular resolution, a period can be as short as one minute (60 seconds) and must be a multiple of 60. For high-resolution metrics that are collected at intervals of less than one minute, the period can be 1, 5, 10, 30, 60, or any multiple of 60. High-resolution metrics are those metrics stored by a PutMetricData call that includes a StorageResolution of 1 second.

      If the StartTime parameter specifies a time stamp that is greater than 3 hours ago, you must specify the period as follows or no data points in that time range is returned:

      Start time between 3 hours and 15 days ago - Use a multiple of 60 seconds (1 minute).
      Start time between 15 and 63 days ago - Use a multiple of 300 seconds (5 minutes).
      Start time greater than 63 days ago - Use a multiple of 3600 seconds (1 hour).
      Statistics (list) --
      The metric statistics, other than percentile. For percentile statistics, use ExtendedStatistics . When calling GetMetricStatistics , you must specify either Statistics or ExtendedStatistics , but not both.

      (string) --
    ExtendedStatistics (list) --
      The percentile statistics. Specify values between p0.0 and p100. When calling GetMetricStatistics , you must specify either Statistics or ExtendedStatistics , but not both.

      (string) --
      Unit (string) -- The unit for a given metric. Metrics may be reported in multiple units. Not supplying a unit results in all units being returned. If the metric only ever reports one unit, specifying a unit has no effect.
  Return type
    dict
  """
  @type get_metric_statistics_opts :: [
    dimensions: [dimension, ...],
    statistics: [binary, ...],
    extended_statistics: [binary, ...]
    unit: binary
  ]
  @spec get_metric_statistics(namespace :: binary, metric_name :: binary, start_time :: %DateTime, end_time :: %DateTime, period :: integer) :: ExAws.Operation.Query.t()
  @spec get_metric_statistics(namespace :: binary, metric_name :: binary, start_time :: %DateTime, end_time :: %DateTime, period :: integer, opts :: get_metric_statistics_opts) :: ExAws.Operation.Query.t()
  def get_metric_statistics(namespace, metric_name, start_time, end_time, period, opts \\ []) do
    [
      {:namespace, namespace},
      {:metric_name, metric_name},
      {:start_time, start_time},
      {:end_time, end_time},
      {:period, period} | opts
      |> build_request(:get_metric_statistics)
    ]
  end

  
end