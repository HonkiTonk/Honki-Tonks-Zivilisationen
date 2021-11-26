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
      
      EingabeBildrate := -1;
      NeueAuflösung := (0, 0);
      
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
                                              ZahlenMinimumExtern => 1,
                                              ZahlenMaximumExtern => 999_999_999);
      
      if
        EingabeAuflösung > 0
      then
         NeueAuflösung.x := Sf.sfUint32 (EingabeAuflösung);
           
      else
         return;
      end if;
      
      EingabeAuflösung := Eingabe.GanzeZahl (TextDateiExtern     => GlobaleTexte.Leer,
                                              ZeileExtern         => 33,
                                              ZahlenMinimumExtern => 1,
                                              ZahlenMaximumExtern => 999_999_999);
      
      if
        EingabeAuflösung > 0
      then
         NeueAuflösung.y := Sf.sfUint32 (EingabeAuflösung);
           
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
                                            ZahlenMaximumExtern => 999_999_999);
      
      if
        EingabeBildrate >= 0
      then
         GrafikAllgemein.BildrateÄndern (NeueBildrateExtern => Sf.sfUint32 (EingabeBildrate));
         
      else
         null;
      end if;
      
   end BildrateÄndern;
   
   
   
   procedure EinstellungenSpeichern
   is begin
      
      if
        EingabeBildrate > -1
      then
         GrafikEinstellungen.FensterEinstellungen.Bildrate := Sf.sfUint32 (EingabeBildrate);
         
      else
         null;
      end if;
      
      if
        NeueAuflösung.x > 0
        and
          NeueAuflösung.y > 0
      then
         GrafikEinstellungen.AktuelleFensterEinstellungen.AktuelleFensterBreite := NeueAuflösung.x;
         GrafikEinstellungen.AktuelleFensterEinstellungen.AktuelleFensterHöhe := NeueAuflösung.y;
         
      else
         null;
      end if;
      
      SchreibenEinstellungen.SchreibenEinstellungen;
      
   end EinstellungenSpeichern;

end OptionenGrafik;
