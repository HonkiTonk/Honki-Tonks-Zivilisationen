private with KartenDatentypen;
private with KartenRecords;

private with LeseWeltkarteneinstellungen;

private with AllgemeineBerechnungen;

package KartengeneratorKuesteLogik is
   pragma Elaborate_Body;

   procedure GenerierungKüstenSeeGewässer;

private
   use type KartenDatentypen.Kartenfeld;
   
   Kartenzeitwert : KartenDatentypen.KartenfeldPositiv;
   
   KartenWert : KartenRecords.AchsenKartenfeldNaturalRecord;
   
   procedure GewässerFestlegen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
     with
       Pre => (
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
              );
   
   
   
   function Basiszeitwert is new AllgemeineBerechnungen.Basiszeitwert (GanzeZahl => KartenDatentypen.KartenfeldPositiv);

end KartengeneratorKuesteLogik;
