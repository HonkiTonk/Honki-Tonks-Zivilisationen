private with KartenDatentypen;
private with KartenRecords;

private with LeseWeltkarteneinstellungen;

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
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
              );

end KartengeneratorKuesteLogik;
