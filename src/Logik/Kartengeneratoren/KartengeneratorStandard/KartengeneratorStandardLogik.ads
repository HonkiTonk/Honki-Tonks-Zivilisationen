private with SystemDatentypenHTSEB;

private with KartenDatentypen;
private with KartenRecords;

private with LeseWeltkarteneinstellungen;

package KartengeneratorStandardLogik is
   pragma Elaborate_Body;

   procedure OberflächeGenerieren
     (LadezeitbasisExtern : in Float)
     with
       Pre => (
                 LadezeitbasisExtern > 0.00
               and
                 LadezeitbasisExtern <= 100.00
              );

private
   use type KartenDatentypen.SenkrechteBasis;
   use type KartenDatentypen.WaagerechteBasis;
      
   SenkrechteZwischenwert : KartenDatentypen.SenkrechtePositiv;
   
   WaagerechteZwischenwert : KartenDatentypen.WaagerechtePositiv;
   
   SenkrechteAnfang : KartenDatentypen.SenkrechteBasis;
   SenkrechteEnde : KartenDatentypen.SenkrechteBasis;
   
   WaagerechteAnfang : KartenDatentypen.WaagerechteBasis;
   WaagerechteEnde : KartenDatentypen.WaagerechteBasis;
   
   type LandmassenArray is array (SystemDatentypenHTSEB.Anfang_Ende_Enum'Range) of KartenRecords.KartenfeldumgebungPositivRecord;
   Landmassen : LandmassenArray;
   Landabstand : LandmassenArray;
   
   BeliebigerLandwert : SystemDatentypenHTSEB.NullBisHundert;
   Quadrantenwert : SystemDatentypenHTSEB.NullBisHundert;
   
   KartenWert : KartenRecords.KartenfeldNaturalRecord;
   
   Schleifenbereich : KartenRecords.LandgrößenNaturalRecord;
   SchleifenbereichZusatz : KartenRecords.LandgrößenNaturalRecord;
   
   -- Das mal auslagern. äöü
   type WahrscheinlichkeitenRecord is record
      
      Anfangswert : SystemDatentypenHTSEB.NullBisHundert;
      Endwert : SystemDatentypenHTSEB.NullBisHundert;
      
   end record;
   
   -- Später Nutzereinstellbar machen. äöü
   WahrscheinlichkeitLandmasse : constant WahrscheinlichkeitenRecord := (20, 80);
   
   WahrscheinlichkeitLand : constant WahrscheinlichkeitenRecord := (0, 95);
   WahrscheinlichkeitWasser : constant WahrscheinlichkeitenRecord := (0, 95);
   
   ZentrumWahrscheinlichkeit : constant SystemDatentypenHTSEB.NullBisHundert := 100;
   MitteWahrscheinlichkeit : constant SystemDatentypenHTSEB.NullBisHundert := 55;
   RandWahrscheinlichkeit : constant SystemDatentypenHTSEB.NullBisHundert := 30;
   
   type QuadrantenArray is array (KartenDatentypen.KartengeneratorQuadranten'Range) of SystemDatentypenHTSEB.NullBisHundert;
   Quadranten : constant QuadrantenArray := (13                          => ZentrumWahrscheinlichkeit,
                                             7 .. 9 | 12 | 14 | 17 .. 19 => MitteWahrscheinlichkeit,
                                             others                      => RandWahrscheinlichkeit);
   
   -- Wo die 25 herkommen:
   --  1,  2,  3,  4,  5
   --  6,  7,  8,  9, 10
   -- 11, 12, 13, 14, 15
   -- 16, 17, 18, 19, 20
   -- 21, 22, 23, 24, 25

   procedure LandVorhanden
     (SenkrechteExtern : in KartenDatentypen.SenkrechtePositiv;
      WaagerechteExtern : in KartenDatentypen.WaagerechtePositiv)
     with
       Pre => (
                 SenkrechteExtern <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 WaagerechteExtern <= LeseWeltkarteneinstellungen.Waagerechte
              );
   
   procedure LandmasseAbstandGenerieren
     (SenkrechteExtern : in KartenDatentypen.SenkrechtePositiv;
      WaagerechteExtern : in KartenDatentypen.WaagerechtePositiv)
     with
       Pre => (
                 SenkrechteExtern <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 WaagerechteExtern <= LeseWeltkarteneinstellungen.Waagerechte
              );

   procedure Wassergrund
     (SenkrechteExtern : in KartenDatentypen.SenkrechteNatural;
      WaagerechteExtern : in KartenDatentypen.WaagerechteNatural)
     with
       Pre => (
                 SenkrechteExtern <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 WaagerechteExtern <= LeseWeltkarteneinstellungen.Waagerechte
              );
   
   procedure Landgrund
     (SenkrechteExtern : in KartenDatentypen.SenkrechteNatural;
      WaagerechteExtern : in KartenDatentypen.WaagerechteNatural)
     with
       Pre => (
                 SenkrechteExtern <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 WaagerechteExtern <= LeseWeltkarteneinstellungen.Waagerechte
              );

end KartengeneratorStandardLogik;
