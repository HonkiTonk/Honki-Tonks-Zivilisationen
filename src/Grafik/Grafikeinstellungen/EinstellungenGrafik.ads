with Sf.Graphics.Color;

with GrafikRecords;

with GrafikKonstanten;
with TextDatentypen;
with SpeziesDatentypen;

package EinstellungenGrafik is
   pragma Elaborate_Body;
      
   Grafikeinstellungen : GrafikRecords.GrafikeinstellungenRecord;
   
   procedure StandardeinstellungenLaden;
   
   -- Beim Record kann ich theoretisch alles beliebig neu ordnen, beim Einlesen/Schreiben muss ich aber immer alles neue an das Ende anhängen!
   GrafikeinstellungenStandard : constant GrafikRecords.GrafikeinstellungenRecord := (
                                                                                      Fenstermodus           => GrafikKonstanten.StandardFenster,
                                                                           
                                                                                      Auflösung              => (GrafikKonstanten.MinimaleAuflösungsbreite, GrafikKonstanten.MinimaleAuflösunghöhe),
                                                                                      Farbtiefe              => 32,
                                                                                      Bildrate               => 30,
                                                                                      
                                                                                      Schriftgrößen          => (
                                                                                                                   TextDatentypen.Überschrift_Enum => 48,
                                                                                                                   TextDatentypen.Standard_Enum    => 32,
                                                                                                                   TextDatentypen.Klein_Enum       => 24
                                                                                                                  ),
                                                                                      
                                                                                      Schriftfarben          => (
                                                                                                                 TextDatentypen.Überschrift_Enum => Sf.Graphics.Color.sfRed,
                                                                                                                 TextDatentypen.Standard_Enum    => Sf.Graphics.Color.sfWhite,
                                                                                                                 TextDatentypen.Ausgewählt_Enum  => Sf.Graphics.Color.sfGreen,
                                                                                                                 TextDatentypen.Mensch_Enum      => Sf.Graphics.Color.sfBlue,
                                                                                                                 TextDatentypen.KI_Enum          => Sf.Graphics.Color.sfYellow,
                                                                                                                 TextDatentypen.Sonstiges_Enum   => Sf.Graphics.Color.sfCyan
                                                                                                                ),
                                                                                      
                                                                                      Schriftstil            => 0,
                                                                                      
                                                                                      Speziesfarben          => (
                                                                                                                 SpeziesDatentypen.Menschen_Enum         => (255, 230, 200, 75),
                                                                                                                 SpeziesDatentypen.Kasrodiah_Enum        => (255, 100, 40, 75),
                                                                                                                 SpeziesDatentypen.Lasupin_Enum          => (65, 145, 140, 75),
                                                                                                                 SpeziesDatentypen.Lamustra_Enum         => (60, 255, 240, 75),
                                                                                                                 SpeziesDatentypen.Manuky_Enum           => (255, 255, 30, 75),
                                                                                                                 SpeziesDatentypen.Suroka_Enum           => (135, 10, 255, 75),
                                                                                                                 SpeziesDatentypen.Pryolon_Enum          => (65, 50, 15, 75),
                                                                                                                 SpeziesDatentypen.Talbidahr_Enum        => (255, 20, 255, 75),
                                                                                                                 SpeziesDatentypen.Moru_Phisihl_Enum     => (255, 255, 180, 75),
                                                                                                                 SpeziesDatentypen.Larinos_Lotaris_Enum  => (255, 210, 135, 75),
                                                                                                                 SpeziesDatentypen.Carupex_Enum          => (210, 210, 210, 75),
                                                                                                                 SpeziesDatentypen.Alary_Enum            => (165, 105, 0, 75),
                                                                                                                 SpeziesDatentypen.Tesorahn_Enum         => (10, 60, 240, 75),
                                                                                                                 SpeziesDatentypen.Natries_Zermanis_Enum => (170, 120, 130, 75),
                                                                                                                 SpeziesDatentypen.Tridatus_Enum         => (20, 95, 20, 75),
                                                                                                                 SpeziesDatentypen.Senelari_Enum         => (0, 210, 0, 75),
                                                                                                                 SpeziesDatentypen.Aspari_2_Enum         => (90, 90, 90, 75),
                                                                                                                 SpeziesDatentypen.Ekropa_Enum           => (255, 30, 30, 75)
                                                                                                                ),
                                                                                                          
                                                                                      EbeneUnterhalbSichtbar => True,
                                                                                      BildrateAnzeigen       => False
                                                                                     );
   
end EinstellungenGrafik;
