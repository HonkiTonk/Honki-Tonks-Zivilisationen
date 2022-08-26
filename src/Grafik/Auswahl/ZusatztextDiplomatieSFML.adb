pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics.Text;
with Sf.Graphics.RenderWindow;

with TextaccessVariablen;
with SystemKonstanten;
with MenueDatentypen;
with GlobaleTexte;
with TextnummernKonstanten;
with SpielVariablen;
with DiplomatieDatentypen;

with TextberechnungenHoeheSFML;
with TextberechnungenBreiteSFML;
with GrafikEinstellungenSFML;
with NachGrafiktask;
with Fehler;

package body ZusatztextDiplomatieSFML is

   function ZusatztextDiplomatie
     (ViewflächeExtern : in Sf.System.Vector2.sfVector2f;
      RealeViewbreiteExtern : in Float)
      return Sf.System.Vector2.sfVector2f
   is begin
      
      Textbreite := 0.00;
      Textposition.y := ViewflächeExtern.y + TextberechnungenHoeheSFML.Zeilenabstand;
      
      TextSchleife:
      for TextSchleifenwert in SystemKonstanten.EndeAbzugGrafik (MenueDatentypen.Diplomatie_Menü_Enum) + 1 .. SystemKonstanten.EndeMenü (MenueDatentypen.Diplomatie_Menü_Enum) loop
         
         Textposition.x := TextberechnungenBreiteSFML.MittelpositionBerechnen (TextAccessExtern => TextaccessVariablen.MenüsSFMLAccess (MenueDatentypen.Diplomatie_Menü_Enum, TextSchleifenwert),
                                                                               ViewbreiteExtern => RealeViewbreiteExtern);
      
         Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.MenüsSFMLAccess (MenueDatentypen.Diplomatie_Menü_Enum, TextSchleifenwert),
                                       position => Textposition);
         
         Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.MenüsSFMLAccess (MenueDatentypen.Diplomatie_Menü_Enum, TextSchleifenwert),
                                            str  => TextSetzen (TextnummerExtern => TextSchleifenwert));
      
         Textbreite := TextberechnungenBreiteSFML.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.MenüsSFMLAccess (MenueDatentypen.Diplomatie_Menü_Enum, TextSchleifenwert),
                                                                           TextbreiteExtern => RealeViewbreiteExtern);
      
         Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                            text         => TextaccessVariablen.MenüsSFMLAccess (MenueDatentypen.Diplomatie_Menü_Enum, TextSchleifenwert));
      
         Textposition.y := Textposition.y + TextberechnungenHoeheSFML.Zeilenabstand;
         
      end loop TextSchleife;
      
      return (Textbreite, Textposition.y);
      
   end ZusatztextDiplomatie;
   
   
   
   function TextSetzen
     (TextnummerExtern : in Positive)
      return Wide_Wide_String
   is begin
      
      if
        TextnummerExtern = SystemKonstanten.EndeMenü (MenueDatentypen.Diplomatie_Menü_Enum)
      then
         case
           SpielVariablen.Diplomatie (NachGrafiktask.AktuelleRasse, NachGrafiktask.KontaktierteRasse).AktuellerZustand
         is
            when DiplomatieDatentypen.Neutral_Enum =>
               Zustandnummer := TextnummernKonstanten.ZeugFrieden;
               
            when DiplomatieDatentypen.Nichtangriffspakt_Enum =>
               Zustandnummer := TextnummernKonstanten.ZeugNichtangriffspakt;
               
            when DiplomatieDatentypen.Krieg_Enum =>
               Zustandnummer := TextnummernKonstanten.ZeugKrieg;
               
            when DiplomatieDatentypen.Unbekannt_Enum =>
               Fehler.GrafikFehler (FehlermeldungExtern => "ZusatztextDiplomatieSFML.TextSetzen - Kontakt ist unbekannt.");
         end case;
         
         Text := GlobaleTexte.Diplomatiemenü (TextnummerExtern) & " " & GlobaleTexte.Zeug (Zustandnummer);
         
      else
         Text := GlobaleTexte.Diplomatiemenü (TextnummerExtern) & " " & SpielVariablen.Diplomatie (NachGrafiktask.AktuelleRasse, NachGrafiktask.KontaktierteRasse).AktuelleSympathieBewertung'Wide_Wide_Image;
      end if;
      
      return To_Wide_Wide_String (Source => Text);
      
   end TextSetzen;

end ZusatztextDiplomatieSFML;
