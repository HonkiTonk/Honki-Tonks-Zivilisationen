with KartenRecords;
with KartenbasisgrundDatentypen;
with KartenartDatentypen;
with KartenDatentypen;

with LeseWeltkarteneinstellungen;

package KartengeneratorArktisberechnungenLogik is
   pragma Elaborate_Body;
   use type KartenDatentypen.SenkrechteBasis;
   use type KartenDatentypen.WaagerechteBasis;
   
   function Arktis
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord;
      GrundExtern : in KartenbasisgrundDatentypen.Basisgrund_Oberfläche_Land_Enum;
      TemperaturExtern : in KartenartDatentypen.Kartentemperatur_Enum)
      return KartenbasisgrundDatentypen.Basisgrund_Oberfläche_Land_Enum
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );
   
private
   
   GrundÄnderungswert : Integer;
         
   KartenWert : KartenRecords.KartenfeldNaturalRecord;
   
   
   
   function Temperaturberechnugnen
     (TemperaturExtern : in KartenartDatentypen.Kartentemperatur_Enum;
      GrundExtern : in KartenbasisgrundDatentypen.Basisgrund_Oberfläche_Land_Enum;
      ÄnderungswertExtern : in Integer)
      return KartenbasisgrundDatentypen.Basisgrund_Oberfläche_Land_Enum;
   
end KartengeneratorArktisberechnungenLogik;
