pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.System.Vector2;
with Sf.Graphics;
with Sf.Graphics.Text;

with RassenDatentypen; use RassenDatentypen;
with SonstigeVariablen;
with KartenRecords;
with KartenRecordKonstanten;
with KartengrundDatentypen;
with KartenVerbesserungDatentypen;

package KarteAllgemeinesSFML is

   function AllgemeineInformationen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      TextpositionExtern : in Sf.System.Vector2.sfVector2f)
      return Sf.System.Vector2.sfVector2f
     with
       Pre =>
         (SonstigeVariablen.RassenImSpiel (RasseExtern) = RassenDatentypen.Spieler_Mensch_Enum
          and
            TextpositionExtern.x > 0.00
          and
            TextpositionExtern.y > 0.00),
   
           Post =>
             (AllgemeineInformationen'Result.x > 0.00
              and
                AllgemeineInformationen'Result.y > 0.00);
   
private

   SchriftartFestgelegt : Boolean := False;
   SchriftfarbeFestgelegt : Boolean := False;
   SchriftgrößeFestgelegt : Boolean := False;

   KartenGrund : KartengrundDatentypen.Kartengrund_Enum;
   KartenFluss : KartengrundDatentypen.Kartenfluss_Enum;
   KartenRessource : KartengrundDatentypen.Karten_Ressourcen_Enum;

   KartenVerbesserung : KartenVerbesserungDatentypen.Karten_Verbesserung_Enum;
   KartenWeg : KartenVerbesserungDatentypen.Karten_Weg_Enum;
   
   Zeilenabstand : Float;

   LetzteKoordinaten : KartenRecords.AchsenKartenfeldPositivRecord := KartenRecordKonstanten.LeerKartenKoordinaten;
   AktuelleKoordinaten : KartenRecords.AchsenKartenfeldPositivRecord;
   
   Textposition : Sf.System.Vector2.sfVector2f;

   type TextAccessArray is array (1 .. 6) of Sf.Graphics.sfText_Ptr;
   TextAccess : constant TextAccessArray := (others => Sf.Graphics.Text.create);
   
   type TextAnzeigenArray is array (TextAccessArray'Range) of Boolean;
   TextAnzeigen : TextAnzeigenArray;
   
   function SchriftartFestlegen
     return Boolean;

   function SchriftgrößenFestlegen
     return Boolean;

   function SchriftfarbenFestlegen
     return Boolean;

end KarteAllgemeinesSFML;
