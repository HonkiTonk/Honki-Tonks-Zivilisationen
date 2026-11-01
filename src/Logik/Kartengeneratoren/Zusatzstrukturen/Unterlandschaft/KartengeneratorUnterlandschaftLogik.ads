private with KartenRecords;

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

   Schleifenbereiche : KartenRecords.LandgrößenNaturalRecord;

end KartengeneratorUnterlandschaftLogik;
