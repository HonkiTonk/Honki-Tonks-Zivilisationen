private with KartenDatentypen;
private with KartenRecords;
private with Weltkarte;

package KartengeneratorKuesteLogik is
   pragma Elaborate_Body;

   procedure GenerierungKüstenSeeGewässer;

private
   use type KartenDatentypen.Kartenfeld;
   
   Kartenzeitwert : KartenDatentypen.KartenfeldNatural;
   
   KartenWert : KartenRecords.AchsenKartenfeldNaturalRecord;
   
   procedure GewässerFestlegen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
     with
       Pre => (
                 KoordinatenExtern.YAchse <= Weltkarte.Karteneinstellungen.Kartengröße.YAchse
               and
                 KoordinatenExtern.XAchse <= Weltkarte.Karteneinstellungen.Kartengröße.XAchse
              );

end KartengeneratorKuesteLogik;
