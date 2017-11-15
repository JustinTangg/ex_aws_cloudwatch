defmodule ExAws.CloudWatch do
  @moduledoc """
  Operations on 

  """
  use ExAws.Utils,
    format_type: :xml,
    non_standard_keys: %{}
  #version of the AWS API
  @version "2010-08-01"

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
  @type statistic_set :: [
    maximum: float,
    minimum: float,
    sample_count: float,
    sum: float
  ]
  @type metric_datum :: [
    dimensions: [dimension, ...],
    metric_name: binary,
    statistic_values: statistic_set,
    storage_resolution: integer,
    timestamp: %DateTime{},
    unit: binary,
    value: float
  ]

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
  def delete_alarms(alarm_names) do
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
  @type delete_dashboards_opts :: [
    dashboard_names: [binary, ...]
  ]
  @spec delete_dashboards() :: ExAws.Operation.Query.t()
  @spec delete_dashboards(opts :: delete_dashboards_opts) :: ExAws.Operation.Query.t()
  def delete_dashboards(opts \\ []) do
    opts |> build_request(:delete_dashboards)
  end

  @doc """
  Retrieves the history for the specified alarm. You can filter the results by date range or item type. If an alarm name is not specified, the histories for all alarms are returned.

  CloudWatch retains the history of an alarm even if you delete the alarm.  

  Parameters
    AlarmName (string) -- The name of the alarm.
    HistoryItemType (string) -- The type of alarm histories to retrieve.
    StartDate (time) -- The starting date to retrieve alarm history.
    EndDate (time) -- The ending date to retrieve alarm history.
    MaxRecords (integer) -- The maximum number of alarm history records to retrieve.
    NextToken (string) -- The token returned by a previous call to indicate that there is more data available.
  Return type
    dict
  """
  @type describe_alarm_history_opts :: [
    alarm_name: binary,
    history_item_type: binary,
    start_date: %DateTime{},
    end_date: %DateTime{},
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
  @spec describe_alarms(opts :: describe_alarm_opts) :: ExAws.Operation.Query.t()
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
    extended_statistics: [binary, ...],
    unit: binary
  ]
  @spec get_metric_statistics(namespace :: binary, metric_name :: binary, start_time :: %DateTime{}, end_time :: %DateTime{}, period :: integer) :: ExAws.Operation.Query.t()
  @spec get_metric_statistics(namespace :: binary, metric_name :: binary, start_time :: %DateTime{}, end_time :: %DateTime{}, period :: integer, opts :: get_metric_statistics_opts) :: ExAws.Operation.Query.t()
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

  @doc """
  Returns a list of the dashboards for your account. If you include DashboardNamePrefix , only those dashboards with names starting with the prefix are listed. Otherwise, all dashboards in your account are listed.

  Parameters
    DashboardNamePrefix (string) -- If you specify this parameter, only the dashboards with names starting with the specified string are listed. The maximum length is 255, and valid characters are A-Z, a-z, 0-9, ".", "-", and "_".
    NextToken (string) -- The token returned by a previous call to indicate that there is more data available.
  Return type
    dict
  """
  @type list_dashboards_opts :: [
    dashboard_name_prefix: binary,
    next_token: binary
  ]
  @spec list_dashboards() :: ExAws.Operation.Query.t()
  @spec list_dashboards(opts :: list_dashboards_opts) :: ExAws.Operation.Query.t()
  def list_dashboards(opts \\ []) do
    opts |> build_request(:list_dashboards)
  end

  @doc """
  List the specified metrics. You can use the returned metrics with GetMetricStatistics to obtain statistical data.

  Up to 500 results are returned for any one call. To retrieve additional results, use the returned token with subsequent calls.

  After you create a metric, allow up to fifteen minutes before the metric appears. Statistics about the metric, however, are available sooner using GetMetricStatistics .

  Parameters
    Namespace (string) -- The namespace to filter against.
    MetricName (string) -- The name of the metric to filter against.
    Dimensions (list) --
      The dimensions to filter against.

      (dict) --
      Represents filters for a dimension.

    Name (string) -- [REQUIRED]
      The dimension name to be matched.

    Value (string) --
      The value of the dimension to be matched.

    NextToken (string) -- The token returned by a previous call to indicate that there is more data available.
  Return type
    dict
  """
  @type list_metrics_opts :: [
    namespace: binary,
    metric_name: binary,
    dimensions: [dimension, ...],
    next_token: binary
  ]
  @spec list_metrics() :: ExAws.Operation.Query.t()
  @spec list_metrics(opts :: list_metrics_opts) :: ExAws.Operation.Query.t()
  def list_metrics(opts \\ []) do
    opts |> build_request(:list_metrics)
  end

  @doc """
  Creates a dashboard if it does not already exist, or updates an existing dashboard. If you update a dashboard, the entire contents are replaced with what you specify here.

  You can have up to 500 dashboards per account. All dashboards in your account are global, not region-specific.

  A simple way to create a dashboard using PutDashboard is to copy an existing dashboard. To copy an existing dashboard using the console, you can load the dashboard and then use the View/edit source command in the Actions menu to display the JSON block for that dashboard. Another way to copy a dashboard is to use GetDashboard , and then use the data returned within DashboardBody as the template for the new dashboard when you call PutDashboard .

  When you create a dashboard with PutDashboard , a good practice is to add a text widget at the top of the dashboard with a message that the dashboard was created by script and should not be changed in the console. This message could also point console users to the location of the DashboardBody script or the CloudFormation template used to create the dashboard.

  Parameters
    DashboardName (string) -- The name of the dashboard. If a dashboard with this name already exists, this call modifies that dashboard, replacing its current contents. Otherwise, a new dashboard is created. The maximum length is 255, and valid characters are A-Z, a-z, 0-9, "-", and "_".
    DashboardBody (string) --
      The detailed information about the dashboard in JSON format, including the widgets to include and their location on the dashboard.

      For more information about the syntax, see CloudWatch-Dashboard-Body-Structure .

  Return type
    dict
  """
  @type put_dashboard_opts :: [
    dashboard_name: binary,
    dashboard_body: binary
  ]
  @spec put_dashboard() :: ExAws.Operation.Query.t()
  @spec put_dashboard(opts :: put_dashboard_opts) :: ExAws.Operation.Query.t()
  def put_dashboard(opts \\ []) do
    opts |> build_request(:put_dashboard)
  end

  @doc """
  Creates or updates an alarm and associates it with the specified metric. Optionally, this operation can associate one or more Amazon SNS resources with the alarm.

  When this operation creates an alarm, the alarm state is immediately set to INSUFFICIENT_DATA . The alarm is evaluated and its state is set appropriately. Any actions associated with the state are then executed.

  When you update an existing alarm, its state is left unchanged, but the update completely overwrites the previous configuration of the alarm.

  If you are an IAM user, you must have Amazon EC2 permissions for some operations:

  ec2:DescribeInstanceStatus and ec2:DescribeInstances for all alarms on EC2 instance status metrics
  ec2:StopInstances for alarms with stop actions
  ec2:TerminateInstances for alarms with terminate actions
  ec2:DescribeInstanceRecoveryAttribute and ec2:RecoverInstances for alarms with recover actions
  If you have read/write permissions for Amazon CloudWatch but not for Amazon EC2, you can still create an alarm, but the stop or terminate actions are not performed. However, if you are later granted the required permissions, the alarm actions that you created earlier are performed.

  If you are using an IAM role (for example, an EC2 instance profile), you cannot stop or terminate the instance using alarm actions. However, you can still see the alarm state and perform any other actions such as Amazon SNS notifications or Auto Scaling policies.

  If you are using temporary security credentials granted using AWS STS, you cannot stop or terminate an EC2 instance using alarm actions.

  You must create at least one stop, terminate, or reboot alarm using either the Amazon EC2 or CloudWatch consoles to create the EC2ActionsAccess IAM role. After this IAM role is created, you can create stop, terminate, or reboot alarms using a command-line interface or API.

  Parameters
    AlarmName (string) --
      [REQUIRED]

      The name for the alarm. This name must be unique within the AWS account.

    AlarmDescription (string) -- The description for the alarm.
    ActionsEnabled (boolean) -- Indicates whether actions should be executed during any changes to the alarm state.
    OKActions (list) --
      The actions to execute when this alarm transitions to an OK state from any other state. Each action is specified as an Amazon Resource Name (ARN).

      Valid Values: arn:aws:automate:region :ec2:stop | arn:aws:automate:region :ec2:terminate | arn:aws:automate:region :ec2:recover

      Valid Values (for use with IAM roles): arn:aws:swf:us-east-1:{customer-account }:action/actions/AWS_EC2.InstanceId.Stop/1.0 | arn:aws:swf:us-east-1:{customer-account }:action/actions/AWS_EC2.InstanceId.Terminate/1.0 | arn:aws:swf:us-east-1:{customer-account }:action/actions/AWS_EC2.InstanceId.Reboot/1.0

      (string) --
    AlarmActions (list) --
      The actions to execute when this alarm transitions to the ALARM state from any other state. Each action is specified as an Amazon Resource Name (ARN).

      Valid Values: arn:aws:automate:region :ec2:stop | arn:aws:automate:region :ec2:terminate | arn:aws:automate:region :ec2:recover

      Valid Values (for use with IAM roles): arn:aws:swf:us-east-1:{customer-account }:action/actions/AWS_EC2.InstanceId.Stop/1.0 | arn:aws:swf:us-east-1:{customer-account }:action/actions/AWS_EC2.InstanceId.Terminate/1.0 | arn:aws:swf:us-east-1:{customer-account }:action/actions/AWS_EC2.InstanceId.Reboot/1.0

      (string) --
    InsufficientDataActions (list) --
      The actions to execute when this alarm transitions to the INSUFFICIENT_DATA state from any other state. Each action is specified as an Amazon Resource Name (ARN).

      Valid Values: arn:aws:automate:region :ec2:stop | arn:aws:automate:region :ec2:terminate | arn:aws:automate:region :ec2:recover

      Valid Values (for use with IAM roles): arn:aws:swf:us-east-1:{customer-account }:action/actions/AWS_EC2.InstanceId.Stop/1.0 | arn:aws:swf:us-east-1:{customer-account }:action/actions/AWS_EC2.InstanceId.Terminate/1.0 | arn:aws:swf:us-east-1:{customer-account }:action/actions/AWS_EC2.InstanceId.Reboot/1.0

      (string) --
    MetricName (string) --
      [REQUIRED]

      The name for the metric associated with the alarm.

    Namespace (string) --
      [REQUIRED]

      The namespace for the metric associated with the alarm.

    Statistic (string) -- The statistic for the metric associated with the alarm, other than percentile. For percentile statistics, use ExtendedStatistic .
    ExtendedStatistic (string) -- The percentile statistic for the metric associated with the alarm. Specify a value between p0.0 and p100.
    Dimensions (list) --
      The dimensions for the metric associated with the alarm.

      (dict) --
      Expands the identity of a metric.

    Name (string) -- [REQUIRED]
      The name of the dimension.

    Value (string) -- [REQUIRED]
      The value representing the dimension measurement.

    Period (integer) --
      [REQUIRED]

      The period, in seconds, over which the specified statistic is applied. Valid values are 10, 30, and any multiple of 60.

      Be sure to specify 10 or 30 only for metrics that are stored by a PutMetricData call with a StorageResolution of 1. If you specify a Period of 10 or 30 for a metric that does not have sub-minute resolution, the alarm still attempts to gather data at the period rate that you specify. In this case, it does not receive data for the attempts that do not correspond to a one-minute data resolution, and the alarm may often lapse into INSUFFICENT_DATA status. Specifying 10 or 30 also sets this alarm as a high-resolution alarm, which has a higher charge than other alarms. For more information about pricing, see Amazon CloudWatch Pricing .

      An alarm's total current evaluation period can be no longer than one day, so Period multiplied by EvaluationPeriods cannot be more than 86,400 seconds.

    Unit (string) --
      The unit of measure for the statistic. For example, the units for the Amazon EC2 NetworkIn metric are Bytes because NetworkIn tracks the number of bytes that an instance receives on all network interfaces. You can also specify a unit when you create a custom metric. Units help provide conceptual meaning to your data. Metric data points that specify a unit of measure, such as Percent, are aggregated separately.

      If you specify a unit, you must use a unit that is appropriate for the metric. Otherwise, the CloudWatch alarm can get stuck in the INSUFFICIENT DATA state.

    EvaluationPeriods (integer) --
      [REQUIRED]

      The number of periods over which data is compared to the specified threshold. An alarm's total current evaluation period can be no longer than one day, so this number multiplied by Period cannot be more than 86,400 seconds.

    Threshold (float) --
      [REQUIRED]

      The value against which the specified statistic is compared.

    ComparisonOperator (string) --
      [REQUIRED]

      The arithmetic operation to use when comparing the specified statistic and threshold. The specified statistic value is used as the first operand.

    TreatMissingData (string) --
      Sets how this alarm is to handle missing data points. If TreatMissingData is omitted, the default behavior of missing is used. For more information, see Configuring How CloudWatch Alarms Treats Missing Data .

      Valid Values: breaching | notBreaching | ignore | missing

    EvaluateLowSampleCountPercentile (string) --
      Used only for alarms based on percentiles. If you specify ignore , the alarm state does not change during periods with too few data points to be statistically significant. If you specify evaluate or omit this parameter, the alarm is always evaluated and possibly changes state no matter how many data points are available. For more information, see Percentile-Based CloudWatch Alarms and Low Data Samples .

      Valid Values: evaluate | ignore

  Returns
    None
  """
  @type put_metric_alarm_opts :: [
    actions_enabled: boolean,
    alarm_actions: [binary, ...],
    alarm_description: binary,
    dimensions: [dimension, ...],
    evaluate_low_sample_count_percentile: binary,
    extended_statistic: binary,
    insufficient_data_actions: [binary, ...],
    ok_actions: [binary, ...],
    statistic: binary,
    treat_missing_data: binary,
    unit: binary
  ]
  @spec put_metric_alarm(alarm_name :: binary, comparison_operator :: binary, evaluation_periods :: integer, metric_name :: binary, namespace :: binary, period :: integer, threshold :: float) :: ExAws.Operation.Query.t()
  @spec put_metric_alarm(alarm_name :: binary, comparison_operator :: binary, evaluation_periods :: integer, metric_name :: binary, namespace :: binary, period :: integer, threshold :: float, opts :: put_metric_alarm_opts) :: ExAws.Operation.Query.t()
  def put_metric_alarm(alarm_name, comparison_operator, evaluation_periods, metric_name, namespace, period, threshold, opts \\ []) do
    [
      {:alarm_name, alarm_name},
      {:comparison_operator, comparison_operator},
      {:evaluation_periods, evaluation_periods},
      {:metric_name, metric_name},
      {:namespace, namespace},
      {:period, period},
      {:threshold, threshold} | opts
    ]
    |> build_request(:put_metric_alarm)
  end

  @doc """
  Publishes metric data points to Amazon CloudWatch. CloudWatch associates the data points with the specified metric. If the specified metric does not exist, CloudWatch creates the metric. When CloudWatch creates a metric, it can take up to fifteen minutes for the metric to appear in calls to ListMetrics .

  Each PutMetricData request is limited to 40 KB in size for HTTP POST requests.

  Although the Value parameter accepts numbers of type Double , CloudWatch rejects values that are either too small or too large. Values must be in the range of 8.515920e-109 to 1.174271e+108 (Base 10) or 2e-360 to 2e360 (Base 2). In addition, special values (for example, NaN, +Infinity, -Infinity) are not supported.

  You can use up to 10 dimensions per metric to further clarify what data the metric collects. For more information about specifying dimensions, see Publishing Metrics in the Amazon CloudWatch User Guide .

  Data points with time stamps from 24 hours ago or longer can take at least 48 hours to become available for GetMetricStatistics from the time they are submitted.

  CloudWatch needs raw data points to calculate percentile statistics. If you publish data using a statistic set instead, you can only retrieve percentile statistics for this data if one of the following conditions is true:

  The SampleCount value of the statistic set is 1
  The Min and the Max values of the statistic set are equal


  """
  @spec put_metric_data_input(metric_data :: [metric_datum, ...], namespace :: binary) :: ExAws.Operation.Query.t()
  def put_metric_data_input(metric_data, namespace) do
    [
      {:metric_data, metric_data},
      {:namespace, namespace}
    ]
    |> build_request(:put_metric_data_input)
  end

  @doc """

  """
  @type wait_until_alarm_exists_opts :: [
    action_prefix: binary,
    alarm_name_prefix: binary,
    alarm_names: [binary, ...],
    max_records: integer,
    next_token: binary,
    state_value: binary
  ]
  @spec wait_until_alarm_exists() :: ExAws.Operation.Query.t()
  @spec wait_until_alarm_exists(opts :: wait_until_alarm_exists_opts) :: ExAws.Operation.Query.t()
  def wait_until_alarm_exists(opts \\ []) do
    opts |> build_request(:wait_until_alarm_exists)
  end
  ####################
  # Helper Functions #
  ####################

  defp build_request(opts, action) do
    opts
    |> Enum.flat_map(&format_param/1)
    |> request(action)
  end

  defp request(params, action) do
    action_string = action |> Atom.to_string() |> Macro.camelize()

    %ExAws.Operation.Query{
      path: "/",
      params: params
              |> filter_nil_params
              |> Map.put("Action", action_string)
              |> Map.put("Version", @version),
      service: :elasticloadbalancing,
      action: action
    }
  end

  defp format_param({:certificates, certificates}) do
    certificates |> format(prefix: "Certificate")
  end

  defp format_param({:attributes, attributes}) do
    attributes
    |> Enum.map(fn {key, value} -> [key: maybe_stringify(key), value: value] end)
    |> format(prefix: "Attribute")    
  end

  defp format_param({:tags, tags}) do
    tags
    |> Enum.map(fn {key, value} -> [key: maybe_stringify(key), value: value] end)
    |> format(prefix: "Tag")
  end

  defp format_param({:resource_arns, resource_arns}) do
    resource_arns |> format(prefix: "ResourceArn")
  end

  defp format_param({:security_groups, security_groups}) do
    security_groups |> format(prefix: "SecurityGroupId")
  end

  defp format_param({:default_actions, actions}) do
    actions |> format(prefix: "Action")
  end

  defp format_param({:start_time, start_time}) do
    start_time
    |> DateTime.to_iso8601
    |> format(prefix: "StartTime")
  end

  defp format_param({:end_time, end_time}) do
    end_time
    |> DateTime.to_iso8601
    |> format(prefix: "EndTime")
  end

  defp format_param({key, parameters}) do
    format([{key, parameters}])
  end
end