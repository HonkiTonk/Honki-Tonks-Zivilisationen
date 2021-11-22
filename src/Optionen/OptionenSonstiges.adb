pragma SPARK_Mode (On);

with GlobaleVariablen;
with SystemKonstanten;
with GlobaleTexte;

with SchreibenEinstellungen;
with EinlesenSprache;
with EinlesenText;

with AuswahlSprache;
with Eingabe;
with AuswahlMenue;
with Fehler;

package body OptionenSonstiges is

   function Sonstiges
     return SystemDatentypen.Rückgabe_Werte_Enum
   is begin
      
      SonstigesSchleife:
      loop

         AuswahlWert := AuswahlMenue.AuswahlMenü (WelchesMenüExtern => SystemDatentypen.Sonstiges_Menü);

         case
           AuswahlWert
         is
            when SystemDatentypen.Anzahl_Speicherstände =>
               AnzahlAutomatischerSpielstände;
               
            when SystemDatentypen.Runden_Bis_Autospeichern =>
               RundenBisAutospeichern;
               
            when SystemDatentypen.Sprache =>
               SpracheWechseln;
               
            when SystemKonstanten.ZurückKonstante | SystemKonstanten.SpielBeendenKonstante | SystemKonstanten.HauptmenüKonstante =>
               SchreibenEinstellungen.SchreibenEinstellungen;
               return AuswahlWert;
               
            when others =>
               Fehler.LogikStopp (FehlermeldungExtern => "OptionenSonstiges.Sonstiges - Ungültige Menüauswahl.");
         end case;
         
      end loop SonstigesSchleife;
      
   end Sonstiges;
   
   
   
   procedure AnzahlAutomatischerSpielstände
   is begin
      
      EingegebeneZahl := Eingabe.GanzeZahl (TextDateiExtern     => GlobaleTexte.Menü_Auswahl,
                                            ZeileExtern         => SystemKonstanten.OptionenSonstigesErsteZeile,
                                            ZahlenMinimumExtern => 0,
                                            ZahlenMaximumExtern => 999_999_999);
      case
        EingegebeneZahl
      is
         when 0 .. 999_999_999 =>
            GlobaleVariablen.NutzerEinstellungen.AnzahlAutosave := EingegebeneZahl;
            
         when SystemKonstanten.GanzeZahlAbbruchKonstante =>
            null;
            
         when others =>
            Fehler.LogikStopp (FehlermeldungExtern => "OptionenSonstiges.AnzahlAutomatischerSpielstände - Ungültige Zahleneingabe.");
      end case;
      
   end AnzahlAutomatischerSpielstände;
   
   
   
   procedure RundenBisAutospeichern
   is begin
      
      EingegebeneZahl := Eingabe.GanzeZahl (TextDateiExtern     => GlobaleTexte.Menü_Auswahl,
                                            ZeileExtern         => SystemKonstanten.OptionenSonstigesErsteZeile + 1,
                                            ZahlenMinimumExtern => 0,
                                            ZahlenMaximumExtern => 999_999_999);

      case
        EingegebeneZahl
      is
         when 1 .. 999_999_999 =>
            GlobaleVariablen.NutzerEinstellungen.RundenBisAutosave := EingegebeneZahl;
            
         when 0 =>
            GlobaleVariablen.NutzerEinstellungen.AnzahlAutosave := EingegebeneZahl;
            
            
         when SystemKonstanten.GanzeZahlAbbruchKonstante =>
            null;
            
         when others =>
            Fehler.LogikStopp (FehlermeldungExtern => "OptionenSonstiges.RundenBisAutospeichern - Ungültige Zahleneingabe.");
      end case;
      
   end RundenBisAutospeichern;
   
   
   
   procedure SpracheWechseln
   is begin
      
      case
        EinlesenSprache.EinlesenSprache
      is
         when True =>
            GlobaleVariablen.NutzerEinstellungen.Sprache := AuswahlSprache.AuswahlSprache;
            EinlesenText.EinlesenDateien;
            
         when False =>
            null;
      end case;
      
   end SpracheWechseln;

end OptionenSonstiges;
