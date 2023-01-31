with KartenDatentypen;
with KartenRecords;
with AufgabenDatentypen;

with LeseWeltkarteneinstellungen;

package FeldeffektEntfernenLogik is
   pragma Elaborate_Body;
   use type KartenDatentypen.Kartenfeld;

   procedure FeldeffektEntfernen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      FeldeffektExtern : in AufgabenDatentypen.Einheitenbefehle_Gelände_Enum)
     with
       Pre => (
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
              );

end FeldeffektEntfernenLogik;
