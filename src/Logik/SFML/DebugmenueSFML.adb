pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with MenueDatentypen;

with SchreibeKarten;
with SchreibeWichtiges;

with AuswahlMenues;
with Fehler;
with Karten;

package body DebugmenueSFML is

   procedure Debugmenü
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      DebugmenüSchleife:
      loop
         
         RückgabeDebugmenü := AuswahlMenues.AuswahlMenüsAufteilung (WelchesMenüExtern => MenueDatentypen.Debug_Menü_Enum);

         case
           RückgabeDebugmenü
         is
            when RueckgabeDatentypen.Menschen_Enum =>
               KarteAufdecken (RasseExtern => RasseExtern);
               
            when RueckgabeDatentypen.Kasrodiah_Enum =>
               SpielVariablen.Wichtiges (RasseExtern).Erforscht := (others => True);
               
            when RueckgabeDatentypen.Lasupin_Enum =>
               SchreibeWichtiges.Geldmenge (RasseExtern         => RasseExtern,
                                            GeldZugewinnExtern  => Integer'Last,
                                            RechnenSetzenExtern => False);
               
            when RueckgabeDatentypen.Lamustra_Enum =>
               SonstigeVariablen.Debug.Allgemeines := not SonstigeVariablen.Debug.Allgemeines;
               
            when RueckgabeDatentypen.Manuky_Enum =>
               SonstigeVariablen.Debug.VolleInformation := not SonstigeVariablen.Debug.VolleInformation;
               
            when RueckgabeDatentypen.Suroka_Enum =>
               SonstigeVariablen.Debug.Sieg := not SonstigeVariablen.Debug.Sieg;
               
            when RueckgabeDatentypen.Fertig_Enum =>
               return;
                  
            when others =>
               Fehler.LogikFehler (FehlermeldungExtern => "DebugmenueSFML.Debugmenü - Keine gültige Menürückgabe.");
         end case;
      
      end loop DebugmenüSchleife;
      
   end Debugmenü;
   
   
   
   procedure KarteAufdecken
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      EbeneSchleife:
      for EAchseSchleifenwert in Karten.WeltkarteArray'Range (1) loop
         YAchseSchleife:
         for YAchseSchleifenwert in Karten.WeltkarteArray'First (2) .. Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse loop
            XAchseSchleife:
            for XAchseSchleifenwert in Karten.WeltkarteArray'First (3) .. Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchse loop
            
               SchreibeKarten.Sichtbar (KoordinatenExtern => (EAchseSchleifenwert, YAchseSchleifenwert, XAchseSchleifenwert),
                                        RasseExtern       => RasseExtern,
                                        SichtbarExtern    => True);
               
            end loop XAchseSchleife;
         end loop YAchseSchleife;
      end loop EbeneSchleife;
      
      DiplomatischenStatusÄndern (NeuerStatusExtern => SystemDatentypen.Neutral_Enum);
      
   end KarteAufdecken;
   
   
   
   procedure DiplomatischenStatusÄndern
     (NeuerStatusExtern : in SystemDatentypen.Status_Untereinander_Enum)
   is begin
      
      RassenErsteSchleife:
      for RasseEinsSchleifenwert in RassenDatentypen.Rassen_Verwendet_Enum'Range loop
         RassenZweiteSchleife:
         for RasseZweiSchleifenwert in RassenDatentypen.Rassen_Verwendet_Enum'Range loop
            
            SpielVariablen.Diplomatie (RasseEinsSchleifenwert, RasseZweiSchleifenwert).AktuellerZustand := NeuerStatusExtern;
            
         end loop RassenZweiteSchleife;
      end loop RassenErsteSchleife;
      
   end DiplomatischenStatusÄndern;
      
   
   
   procedure KarteInfosEinheiten
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is begin
      
      null;
      
   end KarteInfosEinheiten;

end DebugmenueSFML;
