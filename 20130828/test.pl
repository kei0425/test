#!/usr/bin/perl

# データ読み込み
my @data = map {chop;my @line = split '', $_; \@line;} <>;



# スタートとゴール設定
my $startX,$startY,$endX,$endY;
for (my $y = 0; $y <= $#data; $y++) {
    for (my $x = 0; $x <= $#{$data[$y]}; $x++) {
        print "$data[$y]->[$x]";
        if ($data[$y]->[$x] eq 'S') {
            $startX = $x;
            $startY = $y;
        }
        elsif ($data[$y]->[$x] eq 'G') {
            $endX = $x;
            $endY = $y;
        }
    }
    print "\n";
}

# 初期値設定
my %score;
my @rootlist = (
    [
        {x => $startX, y => $startY, real => 0}
    ]
);

print "($startX,$startY)->($endX,$endY)\n";

# メイン
while (true) {
    my @root = @{shift @rootlist};

    my $check = 0;
    foreach my $data (@root) {
        if ($data->{real} == 0) {
            $check = $data;
            last;
        }
    }

    if ($check == 0) {
        # 終了
        last;
    }

    print "($check->{x},$check->{y}) $check->{real}\n";
}

sub get_score {
    my ($x,$y) = @_;

    if (exists $score{"$x,$y"}) {
        # 実測値があればそれ
        return $score{"$x,$y"};
    }

    # なければ最低値
    return abs ($x - $endX) + abs ($y - $endY);
}
