pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with GrafikDatentypen; use GrafikDatentypen;
with TextnummernKonstanten;
with ZahlenDatentypen;
with MenueDatentypen;

with NachGrafiktask;
with NachLogiktask;
with Auswahlaufteilungen;
with EingabeLogik;
with EinstellungenGrafik;
with SchreibenEinstellungen;
with Fehler;

package body OptionenGrafik is

   function OptionenGrafik
     return RueckgabeDatentypen.Rückgabe_Werte_Enum
   is begin
            
      GrafikSchleife:
      loop
         
         AuswahlWert := Auswahlaufteilungen.AuswahlMenüsAufteilung (WelchesMenüExtern => MenueDatentypen.Grafik_Menü_Enum);
         
         case
           AuswahlWert
         is
            when RueckgabeDatentypen.Auflösung_Ändern_Enum =>
               AuflösungÄndern;
            
            when RueckgabeDatentypen.Vollbild_Fenster_Enum =>
               VollbildFenster;
               
            when RueckgabeDatentypen.Bildrate_Ändern_Enum =>
               BildrateÄndern;
               
            when RueckgabeDatentypen.Schriftgröße_Enum =>
               null;
               
            when RueckgabeDatentypen.Speichern_Enum =>
               EinstellungenSpeichern;
               
            when RueckgabeDatentypen.Zurück_Beenden_Enum'Range =>
               return AuswahlWert;
               
            when others =>
               Fehler.LogikFehler (FehlermeldungExtern => "OptionenGrafik.OptionenGrafik - Falsche Menüauswahl.");
         end case;
         
      end loop GrafikSchleife;
      
   end OptionenGrafik;
   
   
   
   procedure AuflösungÄndern
   is begin
      
      EingabeAuflösung := EingabeLogik.GanzeZahl (ZahlenMinimumExtern => 320,
                                                  ZahlenMaximumExtern => ZahlenDatentypen.EigenerInteger'Last,
                                                  WelcheFrageExtern   => TextnummernKonstanten.FrageAuflösungsbreite);
      
      if
        EingabeAuflösung.EingabeAbbruch
      then
         NeueAuflösung.x := Sf.sfUint32 (EingabeAuflösung.EingegebeneZahl);
           
      else
         return;
      end if;
      
      EingabeAuflösung := EingabeLogik.GanzeZahl (ZahlenMinimumExtern => 240,
                                                  ZahlenMaximumExtern => ZahlenDatentypen.EigenerInteger'Last,
                                                  WelcheFrageExtern   => TextnummernKonstanten.FrageAuflösungshöhe);
      
      if
        EingabeAuflösung.EingabeAbbruch
      then
         NeueAuflösung.y := Sf.sfUint32 (EingabeAuflösung.EingegebeneZahl);
           
      else
         NeueAuflösung.x := 0;
         return;
      end if;
      
      EinstellungenGrafik.FensterEinstellungen.FensterBreite := NeueAuflösung.x;
      EinstellungenGrafik.FensterEinstellungen.FensterHöhe := NeueAuflösung.y;
      
      NachLogiktask.Warten := True;
      NachGrafiktask.FensterVerändert := GrafikDatentypen.Auflösung_Verändert_Enum;
      
      ErzeugungNeuesFensterAbwartenSchleife:
      while NachLogiktask.Warten loop
         
         delay 0.002;
         
      end loop ErzeugungNeuesFensterAbwartenSchleife;
            
   end AuflösungÄndern;
   
   
   
   procedure BildrateÄndern
   is begin
      
      EingabeBildrate := EingabeLogik.GanzeZahl (ZahlenMinimumExtern => 0,
                                                ZahlenMaximumExtern => ZahlenDatentypen.EigenerInteger'Last,
                                                WelcheFrageExtern   => TextnummernKonstanten.FrageBildrate);
      
      if
        EingabeBildrate.EingabeAbbruch
      then
         return;
         
      else
         EinstellungenGrafik.FensterEinstellungen.Bildrate := Sf.sfUint32 (EingabeBildrate.EingegebeneZahl);
         NachGrafiktask.FensterVerändert := GrafikDatentypen.Bildrate_Ändern_Enum;
      end if;
            
      NeueBildrateAbwartenSchleife:
      while NachGrafiktask.FensterVerändert = GrafikDatentypen.Bildrate_Ändern_Enum loop
         
         delay 0.002;
         
      end loop NeueBildrateAbwartenSchleife;
      
   end BildrateÄndern;
   
   
   
   procedure VollbildFenster
   is begin
      
      case
        EinstellungenGrafik.FensterEinstellungen.FensterVollbild
      is
         when 7 =>
            EinstellungenGrafik.FensterEinstellungen.FensterVollbild := 8;
            
         when 8 =>
            EinstellungenGrafik.FensterEinstellungen.FensterVollbild := 7;
            
         when others =>
            Fehler.LogikFehler (FehlermeldungExtern => "OptionenGrafik.VollbildFenster - Unbekannter Fenstermodus gewählt.");
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
