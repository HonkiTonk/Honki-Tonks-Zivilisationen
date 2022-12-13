private with Sf.System.Vector2;

with RassenDatentypen;

private with KartenRecords;
private with KartenverbesserungDatentypen;
private with TextaccessVariablen;
private with GrafikRecordKonstanten;
private with KartenextraDatentypen;

with LeseRassenbelegung;

package AllgemeinesSeitenleisteGrafik is
   pragma Elaborate_Body;
   use type RassenDatentypen.Spieler_Enum;

   procedure AllgemeineInformationen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre => (
                 LeseRassenbelegung.Belegung (RasseExtern => RasseExtern) = RassenDatentypen.Mensch_Spieler_Enum
              );
   
private
   
   KartenFluss : KartenextraDatentypen.Fluss_Enum;
   
   KartenRessource : KartenextraDatentypen.Ressourcen_Enum;

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
