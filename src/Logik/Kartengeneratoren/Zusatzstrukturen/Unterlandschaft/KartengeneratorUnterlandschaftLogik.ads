private with KartenRecords;
private with KartenbasisgrundDatentypen;
private with KartenartDatentypen;

package KartengeneratorUnterlandschaftLogik is
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

   AktuellerGrund : KartenbasisgrundDatentypen.Basisgrund_Unterfläche_Enum;

   Temperatur : KartenartDatentypen.Kartentemperatur_Enum;

   Schleifenbereiche : KartenRecords.LandgrößenNaturalRecord;

end KartengeneratorUnterlandschaftLogik;
