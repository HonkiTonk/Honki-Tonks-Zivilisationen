pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with GrafikDatentypen; use GrafikDatentypen;
with TextKonstanten;
with ZahlenDatentypen;
with MenueDatentypen;

with NachGrafiktask;
with NachLogiktask;
with AuswahlMenues;
with Eingabe;
with GrafikEinstellungenSFML;
with SchreibenEinstellungen;
with Fehler;

package body OptionenGrafik is

   function OptionenGrafik
     return RueckgabeDatentypen.Rückgabe_Werte_Enum
   is begin
            
      GrafikSchleife:
      loop
         
         AuswahlWert := AuswahlMenues.AuswahlMenüsAufteilung (WelchesMenüExtern => MenueDatentypen.Grafik_Menü_Enum);
         
         case
           AuswahlWert
         is
            when RueckgabeDatentypen.Auflösung_Ändern_Enum =>
               AuflösungÄndern;
            
               -- Brauche ich diese Option überhaupt?
            when RueckgabeDatentypen.Vollbild_Fenster_Enum =>
               VollbildFenster;
               
            when RueckgabeDatentypen.Bildrate_Ändern_Enum =>
               BildrateÄndern;
               
            when RueckgabeDatentypen.Schriftgröße_Enum =>
               null;
               
            when RueckgabeDatentypen.Speichern_Enum =>
               EinstellungenSpeichern;
               
            when RueckgabeDatentypen.Zurück_Enum | RueckgabeDatentypen.Spiel_Beenden_Enum | RueckgabeDatentypen.Hauptmenü_Enum =>
               return AuswahlWert;
               
            when others =>
               Fehler.LogikFehler (FehlermeldungExtern => "OptionenGrafik.OptionenGrafik - Ungültige Menüauswahl.");
         end case;
         
      end loop GrafikSchleife;
      
   end OptionenGrafik;
   
   
   
   procedure AuflösungÄndern
   is begin
      
      EingabeAuflösung := Eingabe.GanzeZahl (ZeileExtern         => TextKonstanten.FrageAuflösungsbreite,
                                              ZahlenMinimumExtern => 320,
                                              ZahlenMaximumExtern => ZahlenDatentypen.EigenerInteger'Last);
      
      if
        EingabeAuflösung.EingabeAbbruch
      then
         NeueAuflösung.x := Sf.sfUint32 (EingabeAuflösung.EingegebeneZahl);
           
      else
         return;
      end if;
      
      EingabeAuflösung := Eingabe.GanzeZahl (ZeileExtern         => TextKonstanten.FrageAuflösungshöhe,
                                              ZahlenMinimumExtern => 240,
                                              ZahlenMaximumExtern => ZahlenDatentypen.EigenerInteger'Last);
      
      if
        EingabeAuflösung.EingabeAbbruch
      then
         NeueAuflösung.y := Sf.sfUint32 (EingabeAuflösung.EingegebeneZahl);
           
      else
         NeueAuflösung.x := 0;
         return;
      end if;
      
      GrafikEinstellungenSFML.FensterEinstellungen.FensterBreite := NeueAuflösung.x;
      GrafikEinstellungenSFML.FensterEinstellungen.FensterHöhe := NeueAuflösung.y;
      
      NachLogiktask.Warten := True;
      NachGrafiktask.FensterVerändert := GrafikDatentypen.Auflösung_Verändert_Enum;
      
      ErzeugungNeuesFensterAbwartenSchleife:
      while NachLogiktask.Warten loop
         
         delay 0.002;
         
      end loop ErzeugungNeuesFensterAbwartenSchleife;
            
   end AuflösungÄndern;
   
   
   
   procedure BildrateÄndern
   is begin
      
      EingabeBildrate := Eingabe.GanzeZahl (ZeileExtern         => TextKonstanten.FrageBildrate,
                                            ZahlenMinimumExtern => 0,
                                            ZahlenMaximumExtern => ZahlenDatentypen.EigenerInteger'Last);
      
      if
        EingabeBildrate.EingabeAbbruch
      then
         return;
         
      else
         null;
      end if;
      
      GrafikEinstellungenSFML.FensterEinstellungen.Bildrate := Sf.sfUint32 (EingabeBildrate.EingegebeneZahl);
      NachGrafiktask.FensterVerändert := GrafikDatentypen.Bildrate_Ändern_Enum;
      
      NeueBildrateAbwartenSchleife:
      while NachGrafiktask.FensterVerändert = GrafikDatentypen.Bildrate_Ändern_Enum loop
         
         delay 0.002;
         
      end loop NeueBildrateAbwartenSchleife;
      
   end BildrateÄndern;
   
   
   
   procedure VollbildFenster
   is begin
      
      case
        GrafikEinstellungenSFML.FensterEinstellungen.FensterVollbild
      is
         when 7 =>
            GrafikEinstellungenSFML.FensterEinstellungen.FensterVollbild := 8;
            
         when 8 =>
            GrafikEinstellungenSFML.FensterEinstellungen.FensterVollbild := 7;
            
         when others =>
            Fehler.LogikFehler (FehlermeldungExtern => "OptionenGrafik.VollbildFenster - Unbekannter Fenstermodus ausgewählt.");
      end case;
      
      NachGrafiktask.FensterVerändert := GrafikDatentypen.Modus_Verändert_Enum;
      
      ErzeugungNeuesFensterAbwartenSchleife:
      while NachGrafiktask.FensterVerändert = GrafikDatentypen.Modus_Verändert_Enum loop
         
         delay 0.002;
         
      end loop ErzeugungNeuesFensterAbwartenSchleife;
      
   end VollbildFenster;
   
   
   
   procedure EinstellungenSpeichern
   is begin
      
      SchreibenEinstellungen.SchreibenEinstellungen;
      
   end EinstellungenSpeichern;

end OptionenGrafik;
