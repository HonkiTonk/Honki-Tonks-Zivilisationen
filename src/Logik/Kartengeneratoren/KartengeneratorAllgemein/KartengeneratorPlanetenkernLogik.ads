private with SystemDatentypenHTSEB;

private with KartenDatentypen;
private with KartenRecords;

private with LeseWeltkarteneinstellungen;

package KartengeneratorPlanetenkernLogik is
   pragma Elaborate_Body;

   procedure Planetenkern
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

   BeliebigerLandwert : SystemDatentypenHTSEB.NullBisHundert;

   Karteneinstellung : KartenRecords.KartenfeldumgebungRecord;

   Kernbereich : KartenRecords.LandgrößenRecord;

   -- Das mal auslagern. äöü
   type WahrscheinlichkeitenRecord is record

      Anfangswert : SystemDatentypenHTSEB.NullBisHundert;
      Endwert : SystemDatentypenHTSEB.NullBisHundert;

   end record;

   -- Später Nutzereinstellbar machen. äöü
   WahrscheinlichkeitFestmasse : constant WahrscheinlichkeitenRecord := (20, 80);

   procedure LandVorhanden
     (SenkrechteExtern : in KartenDatentypen.SenkrechtePositiv;
      WaagerechteExtern : in KartenDatentypen.WaagerechtePositiv)
     with
       Pre => (
                 SenkrechteExtern <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 WaagerechteExtern <= LeseWeltkarteneinstellungen.Waagerechte
              );

end KartengeneratorPlanetenkernLogik;
