pragma SPARK_Mode (On);

with Sf; use Sf;

with SystemKonstanten;
with GlobaleTexte;

with AuswahlMenue;
with GrafikAllgemein;
with Eingabe;
with GrafikEinstellungen;
with SchreibenEinstellungen;
with Fehler;

package body OptionenGrafik is

   function OptionenGrafik
     return SystemDatentypen.Rückgabe_Werte_Enum
   is begin
            
      GrafikSchleife:
      loop
         
         AuswahlWert := AuswahlMenue.AuswahlMenü (WelchesMenüExtern => SystemDatentypen.Grafik_Menü);
         
         case
           AuswahlWert
         is
            when SystemDatentypen.Auflösung_Ändern =>
               AuflösungÄndern;
            
            when SystemDatentypen.Farbtiefe_Ändern =>
               null;
               
            when SystemDatentypen.Bildrate_Ändern =>
               BildrateÄndern;
               
            when SystemDatentypen.Schriftgröße =>
               null;
               
            when SystemDatentypen.Speichern =>
               EinstellungenSpeichern;
               
            when SystemKonstanten.ZurückKonstante | SystemKonstanten.SpielBeendenKonstante | SystemKonstanten.HauptmenüKonstante =>
               return AuswahlWert;
               
            when others =>
               Fehler.LogikStopp (FehlermeldungExtern => "OptionenGrafik.OptionenGrafik - Ungültige Menüasuwahl.");
         end case;
         
      end loop GrafikSchleife;
      
   end OptionenGrafik;
   
   
   
   procedure AuflösungÄndern
   is begin
      
      EingabeAuflösung := Eingabe.GanzeZahl (TextDateiExtern     => GlobaleTexte.Leer,
                                              ZeileExtern         => 32,
                                              ZahlenMinimumExtern => 320,
                                              ZahlenMaximumExtern => Integer'Last);
      
      if
        EingabeAuflösung.EingabeAbbruch
      then
         NeueAuflösung.x := Sf.sfUint32 (EingabeAuflösung.EingegebeneZahl);
           
      else
         return;
      end if;
      
      EingabeAuflösung := Eingabe.GanzeZahl (TextDateiExtern     => GlobaleTexte.Leer,
                                              ZeileExtern         => 33,
                                              ZahlenMinimumExtern => 240,
                                              ZahlenMaximumExtern => Integer'Last);
      
      if
        EingabeAuflösung.EingabeAbbruch
      then
         NeueAuflösung.y := Sf.sfUint32 (EingabeAuflösung.EingegebeneZahl);
           
      else
         NeueAuflösung.x := 0;
         return;
      end if;
      
      GrafikAllgemein.FensterAuflösungÄndern (NeueAuflösungExtern => NeueAuflösung);
      
   end AuflösungÄndern;
   
   
   
   procedure BildrateÄndern
   is begin
      
      EingabeBildrate := Eingabe.GanzeZahl (TextDateiExtern     => GlobaleTexte.Leer,
                                            ZeileExtern         => 34,
                                            ZahlenMinimumExtern => 0,
                                            ZahlenMaximumExtern => Integer'Last);
      
      if
        EingabeBildrate.EingabeAbbruch
      then
         GrafikAllgemein.BildrateÄndern (NeueBildrateExtern => Sf.sfUint32 (EingabeBildrate.EingegebeneZahl));
         
      else
         null;
      end if;
      
   end BildrateÄndern;
   
   
   
   procedure EinstellungenSpeichern
   is begin
      
      -- Das hier noch einmal überarbeiten, funktioniert nicht richtig mit dem neuen System.
      if
        EingabeBildrate.EingabeAbbruch
      then
         GrafikEinstellungen.FensterEinstellungen.Bildrate := Sf.sfUint32 (EingabeBildrate.EingegebeneZahl);
         
      else
         null;
      end if;
      
      if
        NeueAuflösung.x > 0
        and
          NeueAuflösung.y > 0
      then
         GrafikEinstellungen.AktuelleFensterAuflösung := NeueAuflösung;
         
      else
         null;
      end if;
      
      SchreibenEinstellungen.SchreibenEinstellungen;
      
   end EinstellungenSpeichern;

end OptionenGrafik;
