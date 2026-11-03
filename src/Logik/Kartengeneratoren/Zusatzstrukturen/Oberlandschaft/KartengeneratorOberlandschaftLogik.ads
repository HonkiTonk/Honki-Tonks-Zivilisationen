private with KartenartDatentypen;
private with KartenRecords;
private with KartenbasisgrundDatentypen;

package KartengeneratorOberlandschaftLogik is
   pragma Elaborate_Body;

   procedure Landschaft
     (LadezeitbasisExtern : in Float)
     with
       Pre => (
                 LadezeitbasisExtern > 0.00
               and
                 LadezeitbasisExtern <= 100.00
              );
   
private
   
   AktuellerGrund : KartenbasisgrundDatentypen.Basisgrund_Oberfläche_Enum;
   
   Temperatur : KartenartDatentypen.Kartentemperatur_Enum;
   
   Schleifenbereiche : KartenRecords.LandgrößenNaturalRecord;

end KartengeneratorOberlandschaftLogik;
