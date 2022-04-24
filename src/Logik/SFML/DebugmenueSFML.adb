pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with MenueDatentypen;
with SpielVariablen;
with SystemDatentypen;

with SchreibeKarten;

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
               VolleInformation;
               
            when RueckgabeDatentypen.Lasupin_Enum =>
               AlleTechnologien (RasseExtern => RasseExtern);
               
            when RueckgabeDatentypen.Lamustra_Enum =>
               MaximalesGeld (RasseExtern => RasseExtern);
               
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
         for YAchseSchleifenwert in Karten.WeltkarteArray'First (2) .. Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchsenGröße loop
            XAchseSchleife:
            for XAchseSchleifenwert in Karten.WeltkarteArray'First (3) .. Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchsenGröße loop
            
               SchreibeKarten.Sichtbar (KoordinatenExtern => (EAchseSchleifenwert, YAchseSchleifenwert, XAchseSchleifenwert),
                                        RasseExtern       => RasseExtern,
                                        SichtbarExtern    => True);
               
            end loop XAchseSchleife;
         end loop YAchseSchleife;
      end loop EbeneSchleife;
      
      RassenErsteSchleife:
      for RasseEinsSchleifenwert in RassenDatentypen.Rassen_Verwendet_Enum'Range loop
         RassenZweiteSchleife:
         for RasseZweiSchleifenwert in RassenDatentypen.Rassen_Verwendet_Enum'Range loop
            
            SpielVariablen.Diplomatie (RasseEinsSchleifenwert, RasseZweiSchleifenwert).AktuellerZustand := SystemDatentypen.Neutral_Enum;
            
         end loop RassenZweiteSchleife;
      end loop RassenErsteSchleife;
      
   end KarteAufdecken;
   
   
   
   procedure VolleInformation
   is begin
      
      null;
      
   end VolleInformation;
   
   
   
   procedure AlleTechnologien
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      SpielVariablen.Wichtiges (RasseExtern).Erforscht := (others => True);
      
   end AlleTechnologien;
   
   
   
   procedure MaximalesGeld
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      null;
      
   end MaximalesGeld;

end DebugmenueSFML;
