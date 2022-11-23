with KartenRecords;
with KartengrundDatentypen;
with KartenDatentypen;

with LeseWeltkarteneinstellungen;

package Basisgrundplatzierungssystem is
   pragma Elaborate_Body;
   use type KartenDatentypen.Kartenfeld;

   procedure Basisgrundplatzierung
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      BasisgrundExtern : in KartengrundDatentypen.Basisgrund_Vorhanden_Enum)
     with
       Pre => (
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
              );

end Basisgrundplatzierungssystem;
