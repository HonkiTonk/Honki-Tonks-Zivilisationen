with LadezeitenDatentypen;

with KartengeneratorKuesteLogik;
with KartengeneratorLandschaftLogik;
with KartengeneratorFlussLogik;
with KartengeneratorRessourcenLogik;
with KartengeneratorUnterflaecheLogik;
with KartengeneratorAllgemeinesLogik;
with LadezeitenLogik;
with KartengeneratorVariablenLogik;

package body KartengeneratorLogik is

   procedure Kartengenerator
   is begin
      
      KartengeneratorAllgemeinesLogik.GenerierungAllgemeines;
      -- Wenn ich die Einstellungen hier noch einmal auf Korrketheit prüfen will, sollte dann die Prüfung nicht am Anfang kommen? äöü
      -- Setzt im Moment nur die Ressourcen und kann deswegen nicht entfernt werden, später mal erweitern. äöü
      PrüfeEinstellungen;
      LadezeitenLogik.FortschrittSpielweltMaximum (WelcheBerechnungenExtern => LadezeitenDatentypen.Generiere_Allgemeines_Enum);
      
      KartengeneratorKuesteLogik.GenerierungKüstenSeeGewässer;
      LadezeitenLogik.FortschrittSpielweltMaximum (WelcheBerechnungenExtern => LadezeitenDatentypen.Generiere_Küstenwasser_Enum);
      
      KartengeneratorLandschaftLogik.GenerierungLandschaft;
      LadezeitenLogik.FortschrittSpielweltMaximum (WelcheBerechnungenExtern => LadezeitenDatentypen.Generiere_Landschaft_Enum);
      
      KartengeneratorUnterflaecheLogik.GenerierungLandschaft;
      LadezeitenLogik.FortschrittSpielweltMaximum (WelcheBerechnungenExtern => LadezeitenDatentypen.Generiere_Unterfläche_Enum);
      
      KartengeneratorFlussLogik.GenerierungFlüsse;
      LadezeitenLogik.FortschrittSpielweltMaximum (WelcheBerechnungenExtern => LadezeitenDatentypen.Generiere_Flüsse_Enum);
      
      KartengeneratorRessourcenLogik.GenerierungRessourcen;
      LadezeitenLogik.FortschrittSpielweltMaximum (WelcheBerechnungenExtern => LadezeitenDatentypen.Generiere_Ressourcen_Enum);
      
   end Kartengenerator;
   
   
   
   -- Das hier ist vermutlich noch nicht fertig gebaut? äöü
   -- Ergibt was auch immer ich hier machen wollte überhaupt noch Sinn? äöü
   procedure PrüfeEinstellungen
   is begin
      
      RessourcenSchleife:
      for RessourcenSchleifenwert in KartengeneratorVariablenLogik.KartenressourcenWahrscheinlichkeitenArray'Range loop
         
         KartengeneratorVariablenLogik.KartenressourcenWahrscheinlichkeiten (RessourcenSchleifenwert)
           := KartengeneratorVariablenLogik.StandardKartenressourcenWahrscheinlichkeiten (KartengeneratorVariablenLogik.Kartenparameter.Kartenressourcen, RessourcenSchleifenwert);
         
      end loop RessourcenSchleife;
      
   end PrüfeEinstellungen;

end KartengeneratorLogik;
