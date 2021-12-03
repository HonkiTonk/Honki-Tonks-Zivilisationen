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
        EingegebeneZahl.EingabeAbbruch
      is
         when True =>
            GlobaleVariablen.NutzerEinstellungen.AnzahlAutosave := EingegebeneZahl.EingegebeneZahl;
            
         when False =>
            null;
      end case;
      
   end AnzahlAutomatischerSpielstände;
   
   
   
   procedure RundenBisAutospeichern
   is begin
      
      EingegebeneZahl := Eingabe.GanzeZahl (TextDateiExtern     => GlobaleTexte.Menü_Auswahl,
                                            ZeileExtern         => SystemKonstanten.OptionenSonstigesErsteZeile + 1,
                                            ZahlenMinimumExtern => 0,
                                            ZahlenMaximumExtern => 999_999_999);

      case
        EingegebeneZahl.EingabeAbbruch
      is
         when True =>
            if
              EingegebeneZahl.EingegebeneZahl in 1 .. 999_999_999
            then
               GlobaleVariablen.NutzerEinstellungen.RundenBisAutosave := EingegebeneZahl.EingegebeneZahl;
               
            elsif
              EingegebeneZahl.EingegebeneZahl = 0
            then
               GlobaleVariablen.NutzerEinstellungen.AnzahlAutosave := EingegebeneZahl.EingegebeneZahl;
               
            else
               Fehler.LogikStopp (FehlermeldungExtern => "OptionenSonstiges.RundenBisAutospeichern - Ungültige Zahl wurd eingegeben.");
            end if;
            
         when False =>
            null;
      end case;
      
   end RundenBisAutospeichern;
   
   
   
   procedure SpracheWechseln
   is begin
      
      -- Das hier mit dem Einlesen.Einlesen zusammenführen? Geht das überhaupt sinnvoll?
      case
        EinlesenSprache.EinlesenSprache
      is
         when True =>
            GewählteSprache := AuswahlSprache.AuswahlSprache;
            
            if
              GewählteSprache = SystemKonstanten.LeerUnboundedString
            then
               null;
               
            else
               GlobaleVariablen.NutzerEinstellungen.Sprache := GewählteSprache;
               EinlesenText.EinlesenDateien;
            end if;
            
         when False =>
            Fehler.LogikStopp (FehlermeldungExtern => "OptionenSonstiges.SpracheWechseln - Sprachen wurden nicht gefunden.");
      end case;
      
   end SpracheWechseln;

end OptionenSonstiges;
