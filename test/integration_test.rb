require 'minitest/autorun'

describe 'findRoute' do

  it 'gives the correct output for a single-flight route' do
    `ruby findRoute.rb 0 36 12.5`.must_equal <<-EOF

1. Albany(NY) - Miami(FL)\t0:00 3:02 $449.02

Total Cost: $449.02

EOF
  end

  it 'gives the correct output for a multi-flight route' do
    `ruby findRoute.rb 1 36 12.5`.must_equal <<-EOF

1. Albuquerque(NM) - Houston(TX)\t0:00 2:00 $316.20
2. Houston(TX) - Miami(FL)\t4:00 6:27 $310.07

Total Cost: $626.27

EOF
  end

  it 'takes hourly rate into account' do
    `ruby findRoute.rb 0 36 1`.must_equal <<-EOF

1. Albany(NY) - NewYork(NY)\t0:00 0:40 $94.67
2. NewYork(NY) - Miami(FL)\t2:40 5:26 $294.78

Total Cost: $389.45

EOF
  end
end
