with Sf.System.Vector2;

with RassenDatentypen; use RassenDatentypen;
with SpielVariablen;

private with KartenRecords;
private with KartengrundDatentypen;
private with KartenverbesserungDatentypen;
private with TextaccessVariablen;
private with GrafikRecordKonstanten;

package AllgemeinesSeitenleisteGrafik is
   pragma Elaborate_Body;
   
   procedure Leer
     (ViewbereichExtern : in Positive);

   procedure AllgemeineInformationen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre => (
                 SpielVariablen.Rassenbelegung (RasseExtern).Belegung = RassenDatentypen.Mensch_Spieler_Enum
              );
   
private
   
   KartenFluss : KartengrundDatentypen.Kartenfluss_Enum;
   
   KartenRessource : KartengrundDatentypen.Kartenressourcen_Enum;

   KartenVerbesserung : KartenverbesserungDatentypen.Karten_Verbesserung_Enum;
   KartenWeg : KartenverbesserungDatentypen.Karten_Weg_Enum;
   
   Textbreite : Float;
   RealeYPosition : Float;
   
   Gesamtgrund : KartenRecords.KartengrundRecord;

   AktuelleKoordinaten : KartenRecords.AchsenKartenfeldNaturalRecord;
   
   Viewfläche : Sf.System.Vector2.sfVector2f := GrafikRecordKonstanten.StartgrößeView;
   Textposition : Sf.System.Vector2.sfVector2f;
   
   type TextAnzeigenArray is array (TextaccessVariablen.KarteAllgemeinesAccess'Range) of Boolean;
   TextAnzeigen : TextAnzeigenArray;
   
end AllgemeinesSeitenleisteGrafik;
