pragma SPARK_Mode (On);

with Sf.Graphics;

with SystemDatentypen; use SystemDatentypen;
with GlobaleVariablen;
with EinheitStadtDatentypen;

package ForschungAllgemein is

   procedure Beschreibung
     (IDExtern : in EinheitStadtDatentypen.ForschungIDMitNullWert;
      TextAccessExtern : in Sf.Graphics.sfText_Ptr);

   procedure Forschung
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= SystemDatentypen.Leer);

   procedure ForschungsBaum
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= SystemDatentypen.Leer);

   procedure ForschungFortschritt;



   function ForschungAnforderungErfüllt
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      ForschungIDExtern : in EinheitStadtDatentypen.ForschungID)
      return Boolean
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= SystemDatentypen.Leer);

private

   ErsterDurchlauf : Boolean;

   WasErforschtWerdenSoll : EinheitStadtDatentypen.ForschungIDMitNullWert;
   AktuellesForschungsprojekt : EinheitStadtDatentypen.ForschungIDMitNullWert;

   AktuelleAuswahl : EinheitStadtDatentypen.MinimimMaximumID;
   Ende : EinheitStadtDatentypen.ForschungID;

   ForschungID : Positive;

   procedure Ermöglicht
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      ForschungNummerExtern : in EinheitStadtDatentypen.ForschungID)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= SystemDatentypen.Leer);

   procedure Benötigt
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      ForschungNummerExtern : in EinheitStadtDatentypen.ForschungID)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= SystemDatentypen.Leer);

   procedure FortschrittMensch
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum);

   procedure FortschrittKI
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum);



   function AuswahlForschungNeu
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.ForschungIDMitNullWert
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= SystemDatentypen.Leer);

   function ForschungAuswahl
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.ForschungIDMitNullWert
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= SystemDatentypen.Leer);

end ForschungAllgemein;
