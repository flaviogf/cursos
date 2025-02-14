namespace ArdalisRating.LSP
{
    public class AutoPolicyRater : IRater
    {
        private readonly RatingEngine _engine;

        private readonly ConsoleLogger _logger;

        public AutoPolicyRater(RatingEngine engine, ConsoleLogger logger)
        {
            _engine = engine;
            _logger = logger;
        }

        public void Rate(Policy policy)
        {
            _logger.Log("Rating AUTO policy...");

            _logger.Log("Validating policy.");

            if (string.IsNullOrEmpty(policy.Make))
            {
                _logger.Log("Auto policy must specify make");

                return;
            }

            if (policy.Make == "BMW")
            {
                if (policy.Deductible < 500)
                {
                    _engine.Rating = 1000m;
                }

                _engine.Rating = 900m;
            }
        }
    }
}
