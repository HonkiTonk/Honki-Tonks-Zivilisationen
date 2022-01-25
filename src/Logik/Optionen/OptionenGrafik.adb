pragma SPARK_Mode (On);

with SystemKonstanten;
with TextKonstanten;

with InteraktionGrafiktask; use InteraktionGrafiktask;
with AuswahlMenue;
with Eingabe;
with EinstellungenSFML;
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
            
               -- Brauche ich diese Option überhaupt?
            when SystemDatentypen.Vollbild_Fenster =>
               VollbildFenster;
               
            when SystemDatentypen.Bildrate_Ändern =>
               BildrateÄndern;
               
            when SystemDatentypen.Schriftgröße =>
               null;
               
            when SystemDatentypen.Speichern =>
               EinstellungenSpeichern;
               
            when SystemKonstanten.ZurückKonstante | SystemKonstanten.SpielBeendenKonstante | SystemKonstanten.HauptmenüKonstante =>
               return AuswahlWert;
               
            when others =>
               Fehler.LogikStopp (FehlermeldungExtern => "OptionenGrafik.OptionenGrafik - Ungültige Menüauswahl.");
         end case;
         
      end loop GrafikSchleife;
      
   end OptionenGrafik;
   
   
   
   procedure AuflösungÄndern
   is begin
      
      EingabeAuflösung := Eingabe.GanzeZahl (ZeileExtern         => TextKonstanten.FrageAuflösungsbreite,
                                              ZahlenMinimumExtern => 320,
                                              ZahlenMaximumExtern => SystemDatentypen.Grenzen'Last);
      
      if
        EingabeAuflösung.EingabeAbbruch
      then
         NeueAuflösung.x := Sf.sfUint32 (EingabeAuflösung.EingegebeneZahl);
           
      else
         return;
      end if;
      
      EingabeAuflösung := Eingabe.GanzeZahl (ZeileExtern         => TextKonstanten.FrageAuflösungshöhe,
                                              ZahlenMinimumExtern => 240,
                                              ZahlenMaximumExtern => SystemDatentypen.Grenzen'Last);
      
      if
        EingabeAuflösung.EingabeAbbruch
      then
         NeueAuflösung.y := Sf.sfUint32 (EingabeAuflösung.EingegebeneZahl);
           
      else
         NeueAuflösung.x := 0;
         return;
      end if;
      
      EinstellungenSFML.FensterEinstellungen.FensterBreite := NeueAuflösung.x;
      EinstellungenSFML.FensterEinstellungen.FensterHöhe := NeueAuflösung.y;
      
      InteraktionGrafiktask.FensterVerändert := InteraktionGrafiktask.Auflösung_Verändert;
      
      ErzeugungNeuesFensterAbwartenSchleife:
      while InteraktionGrafiktask.FensterVerändert = InteraktionGrafiktask.Auflösung_Verändert loop
         
         delay 0.002;
         
      end loop ErzeugungNeuesFensterAbwartenSchleife;
            
   end AuflösungÄndern;
   
   
   
   procedure BildrateÄndern
   is begin
      
      EingabeBildrate := Eingabe.GanzeZahl (ZeileExtern         => TextKonstanten.FrageBildrate,
                                            ZahlenMinimumExtern => 0,
                                            ZahlenMaximumExtern => SystemDatentypen.Grenzen'Last);
      
      if
        EingabeBildrate.EingabeAbbruch
      then
         return;
         
      else
         null;
      end if;
      
      EinstellungenSFML.FensterEinstellungen.Bildrate := Sf.sfUint32 (EingabeBildrate.EingegebeneZahl);
      InteraktionGrafiktask.FensterVerändert := InteraktionGrafiktask.Bildrate_Ändern;
      
      NeueBildrateAbwartenSchleife:
      while InteraktionGrafiktask.FensterVerändert = InteraktionGrafiktask.Bildrate_Ändern loop
         
         delay 0.002;
         
      end loop NeueBildrateAbwartenSchleife;
      
   end BildrateÄndern;
   
   
   
   procedure VollbildFenster
   is begin
      
      case
        EinstellungenSFML.FensterEinstellungen.FensterVollbild
      is
         when 7 =>
            EinstellungenSFML.FensterEinstellungen.FensterVollbild := 8;
            
         when 8 =>
            EinstellungenSFML.FensterEinstellungen.FensterVollbild := 7;
            
         when others =>
            Fehler.LogikStopp (FehlermeldungExtern => "OptionenGrafik.VollbildFenster - Unbekannter Fenstermodus ausgewählt.");
      end case;
      
      InteraktionGrafiktask.FensterVerändert := InteraktionGrafiktask.Modus_Verändert;
      
      ErzeugungNeuesFensterAbwartenSchleife:
      while InteraktionGrafiktask.FensterVerändert = InteraktionGrafiktask.Modus_Verändert loop
         
         delay 0.002;
         
      end loop ErzeugungNeuesFensterAbwartenSchleife;
      
   end VollbildFenster;
   
   
   
   procedure EinstellungenSpeichern
   is begin
      
      SchreibenEinstellungen.SchreibenEinstellungen;
      
   end EinstellungenSpeichern;

end OptionenGrafik;
