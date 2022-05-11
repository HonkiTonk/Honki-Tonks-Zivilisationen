pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.System.Vector2;
with Sf.Graphics;
with Sf.Graphics.Text;

with RassenDatentypen; use RassenDatentypen;
with StadtDatentypen;
with EinheitenDatentypen;
with EinheitenRecords;
with SpielVariablen;
with SonstigeVariablen;

package AuswahlStadtEinheit is
      
   AktuelleAuswahl : Integer;
   
   type MöglicheAuswahlenArray is array (0 .. EinheitenRecords.TransporterArray'Last) of EinheitenDatentypen.MaximaleEinheitenMitNullWert;
   
   type AuswahlRecord is record
      
      StadtEinheit : Boolean;
      MöglicheAuswahlen : MöglicheAuswahlenArray;
      
   end record;
   
   WelcheAuswahl : AuswahlRecord;

   --------------------- Contracts hinzufügen.
   function AuswahlStadtEinheit
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      StadtNummerExtern : in StadtDatentypen.MaximaleStädteMitNullWert;
      EinheitNummerExtern : in EinheitenDatentypen.MaximaleEinheitenMitNullWert)
      return Integer
     with
       Pre =>
         (StadtNummerExtern in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (RasseExtern).Städtegrenze
          and
            EinheitNummerExtern in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (RasseExtern).Einheitengrenze
          and
            SonstigeVariablen.RassenImSpiel (RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum);
   
private

   SchriftartFestgelegt : Boolean := False;
   SchriftgrößeFestgelegt : Boolean := False;
      
   Zeilenabstand : Float;
   
   MausZeigerPosition : Sf.System.Vector2.sfVector2i;
   
   TextPositionMaus : Sf.System.Vector2.sfVector2f;
   
   TextAccess : constant Sf.Graphics.sfText_Ptr := Sf.Graphics.Text.create;
   
   procedure MausAuswahl
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (SonstigeVariablen.RassenImSpiel (RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum);

end AuswahlStadtEinheit;
