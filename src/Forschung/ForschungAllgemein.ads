pragma SPARK_Mode (On);

with SonstigeDatentypen; use SonstigeDatentypen;
with GlobaleVariablen;
with EinheitStadtDatentypen;

package ForschungAllgemein is

   procedure Beschreibung
     (IDExtern : in EinheitStadtDatentypen.ForschungIDMitNullWert);

   procedure Forschung
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= SonstigeDatentypen.Leer);

   procedure ForschungsBaum
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= SonstigeDatentypen.Leer);

   procedure ForschungFortschritt;



   function ForschungAnforderungErfüllt
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum;
      ForschungIDExtern : in EinheitStadtDatentypen.ForschungID)
      return Boolean
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= SonstigeDatentypen.Leer);

private

   ErsterDurchlauf : Boolean;

   WasErforschtWerdenSoll : EinheitStadtDatentypen.ForschungIDMitNullWert;
   AktuellesForschungsprojekt : EinheitStadtDatentypen.ForschungIDMitNullWert;

   AktuelleAuswahl : EinheitStadtDatentypen.MinimimMaximumID;
   Ende : EinheitStadtDatentypen.ForschungID;

   procedure Ermöglicht
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum;
      ForschungNummerExtern : in EinheitStadtDatentypen.ForschungID)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= SonstigeDatentypen.Leer);

   procedure Benötigt
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum;
      ForschungNummerExtern : in EinheitStadtDatentypen.ForschungID)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= SonstigeDatentypen.Leer);

   procedure FortschrittMensch
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum);

   procedure FortschrittKI
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum);



   function AuswahlForschungNeu
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.ForschungIDMitNullWert
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= SonstigeDatentypen.Leer);

   function ForschungAuswahl
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.ForschungIDMitNullWert
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= SonstigeDatentypen.Leer);

end ForschungAllgemein;