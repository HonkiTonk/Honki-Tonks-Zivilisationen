with KartenRecords;
with KartenbasisgrundDatentypen;
with KartenDatentypen;

with LeseWeltkarteneinstellungen;

package KartengeneratorGraslandberechnungenLogik is
   pragma Elaborate_Body;
   use type KartenDatentypen.SenkrechteBasis;
   use type KartenDatentypen.WaagerechteBasis;
   
   function Grasland
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord;
      GrundExtern : in KartenbasisgrundDatentypen.Basisgrund_Oberfläche_Land_Enum)
      return KartenbasisgrundDatentypen.Basisgrund_Oberfläche_Land_Enum
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );
   
private
   
   NeuerGrund : KartenbasisgrundDatentypen.Basisgrund_Oberfläche_Land_Enum;
         
   KartenWert : KartenRecords.KartenfeldNaturalRecord;

end KartengeneratorGraslandberechnungenLogik;
