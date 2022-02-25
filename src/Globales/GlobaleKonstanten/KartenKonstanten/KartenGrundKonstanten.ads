pragma SPARK_Mode (On);

with KartenDatentypen;

package KartenGrundKonstanten is

   LeerGrund : constant KartenDatentypen.Karten_Grund_Enum := KartenDatentypen.Leer_Grund;
   LeerRessource : constant KartenDatentypen.Karten_Grund_Enum := KartenDatentypen.Leer_Grund;
   LeerFluss : constant KartenDatentypen.Karten_Grund_Enum := KartenDatentypen.Leer_Grund;
   
   -- Kartenfelder
   WasserKonstante : constant KartenDatentypen.Karten_Grund_Enum := KartenDatentypen.Wasser;
   KüstengewässerKonstante : constant KartenDatentypen.Karten_Grund_Enum := KartenDatentypen.Küstengewässer;
   UnterwasserWasserKonstante : constant KartenDatentypen.Karten_Grund_Enum := KartenDatentypen.Unterwasser_Wasser;
   UnterwasserKüstengewässerKonstante : constant KartenDatentypen.Karten_Grund_Enum := KartenDatentypen.Unterwasser_Küstengewässer;
   EisKonstante : constant KartenDatentypen.Karten_Grund_Enum := KartenDatentypen.Eis;
   UnterwasserEisKonstante : constant KartenDatentypen.Karten_Grund_Enum := KartenDatentypen.Unterwasser_Eis;
   LavaKonstante : constant KartenDatentypen.Karten_Grund_Enum := KartenDatentypen.Lava;
   PlanetenkernKonstante : constant KartenDatentypen.Karten_Grund_Enum := KartenDatentypen.Planetenkern;
   TundraKonstante : constant KartenDatentypen.Karten_Grund_Enum := KartenDatentypen.Tundra;
   WüsteKonstante : constant KartenDatentypen.Karten_Grund_Enum := KartenDatentypen.Wüste;
   HügelKonstante : constant KartenDatentypen.Karten_Grund_Enum := KartenDatentypen.Hügel;
   GebirgeKonstante : constant KartenDatentypen.Karten_Grund_Enum := KartenDatentypen.Gebirge;
   WaldKonstante : constant KartenDatentypen.Karten_Grund_Enum := KartenDatentypen.Wald;
   DschungelKonstante : constant KartenDatentypen.Karten_Grund_Enum := KartenDatentypen.Dschungel;
   SumpfKonstante : constant KartenDatentypen.Karten_Grund_Enum := KartenDatentypen.Sumpf;
   FlachlandKonstante : constant KartenDatentypen.Karten_Grund_Enum := KartenDatentypen.Flachland;
   HügelMitKonstante : constant KartenDatentypen.Karten_Grund_Enum := KartenDatentypen.Hügel_Mit;
   WolkenKonstante : constant KartenDatentypen.Karten_Grund_Enum := KartenDatentypen.Wolken;
   WeltraumKonstante : constant KartenDatentypen.Karten_Grund_Enum := KartenDatentypen.Weltraum;
   ErdeKonstante : constant KartenDatentypen.Karten_Grund_Enum := KartenDatentypen.Erde;
   ErdgesteinKonstante : constant KartenDatentypen.Karten_Grund_Enum := KartenDatentypen.Erdgestein;
   SandKonstante : constant KartenDatentypen.Karten_Grund_Enum := KartenDatentypen.Sand;
   GesteinKonstante : constant KartenDatentypen.Karten_Grund_Enum := KartenDatentypen.Gestein;
   KorallenKonstante : constant KartenDatentypen.Karten_Grund_Enum := KartenDatentypen.Korallen;
   UnterwasserWaldKonstante : constant KartenDatentypen.Karten_Grund_Enum := KartenDatentypen.Unterwasser_Wald;
                              
   -- Ressourcen
   FischKonstante : constant KartenDatentypen.Karten_Grund_Enum := KartenDatentypen.Fisch;
   WalKonstante : constant KartenDatentypen.Karten_Grund_Enum := KartenDatentypen.Wal;
   KohleKonstante : constant KartenDatentypen.Karten_Grund_Enum := KartenDatentypen.Kohle;
   EisenKonstante : constant KartenDatentypen.Karten_Grund_Enum := KartenDatentypen.Eisen;
   ÖlKonstante : constant KartenDatentypen.Karten_Grund_Enum := KartenDatentypen.Öl;
   HochwertigerBodenKonstante : constant KartenDatentypen.Karten_Grund_Enum := KartenDatentypen.Hochwertiger_Boden;
   GoldKonstante : constant KartenDatentypen.Karten_Grund_Enum := KartenDatentypen.Gold;
                              
   -- Fluss
   FlusskreuzungVierKonstante : constant KartenDatentypen.Karten_Grund_Enum := KartenDatentypen.Flusskreuzung_Vier;
   FlussWaagrechtKonstante : constant KartenDatentypen.Karten_Grund_Enum := KartenDatentypen.Fluss_Waagrecht;
   FlussSenkrechtKonstante : constant KartenDatentypen.Karten_Grund_Enum := KartenDatentypen.Fluss_Senkrecht;
   FlusskurveUntenRechtsKonstante : constant KartenDatentypen.Karten_Grund_Enum := KartenDatentypen.Flusskurve_Unten_Rechts;
   FlusskurveUntenLinksKonstante : constant KartenDatentypen.Karten_Grund_Enum := KartenDatentypen.Flusskurve_Unten_Links;
   FlusskurveObenRechtsKonstante : constant KartenDatentypen.Karten_Grund_Enum := KartenDatentypen.Flusskurve_Oben_Rechts;
   FlusskurveObenLinksKonstante : constant KartenDatentypen.Karten_Grund_Enum := KartenDatentypen.Flusskurve_Oben_Links;
   FlusskreuzungDreiObenKonstante : constant KartenDatentypen.Karten_Grund_Enum := KartenDatentypen.Flusskreuzung_Drei_Oben;
   FlusskreuzungDreiUntenKonstante : constant KartenDatentypen.Karten_Grund_Enum := KartenDatentypen.Flusskreuzung_Drei_Unten;
   FlusskreuzungDreiRechtsKonstante : constant KartenDatentypen.Karten_Grund_Enum := KartenDatentypen.Flusskreuzung_Drei_Rechts;
   FlusskreuzungDreiLinksKonstante : constant KartenDatentypen.Karten_Grund_Enum := KartenDatentypen.Flusskreuzung_Drei_Links;
   FlussendstückLinksKonstante : constant KartenDatentypen.Karten_Grund_Enum := KartenDatentypen.Flussendstück_Links;
   FlussendstückRechtsKonstante : constant KartenDatentypen.Karten_Grund_Enum := KartenDatentypen.Flussendstück_Rechts;
   FlussendstückUntenKonstante : constant KartenDatentypen.Karten_Grund_Enum := KartenDatentypen.Flussendstück_Unten;
   FlussendstückObenKonstante : constant KartenDatentypen.Karten_Grund_Enum := KartenDatentypen.Flussendstück_Oben;
   SeeKonstante : constant KartenDatentypen.Karten_Grund_Enum := KartenDatentypen.See;
                              
   -- Unterirdischer Fluss
   UnterirdischeFlusskreuzungVierKonstante : constant KartenDatentypen.Karten_Grund_Enum := KartenDatentypen.Unterirdische_Flusskreuzung_Vier;
   UnterirdischerFlussWaagrechtKonstante : constant KartenDatentypen.Karten_Grund_Enum := KartenDatentypen.Unterirdischer_Fluss_Waagrecht;
   UnterirdischerFlussSenkrechtKonstante : constant KartenDatentypen.Karten_Grund_Enum := KartenDatentypen.Unterirdischer_Fluss_Senkrecht;
   UnterirdischeFlusskurveUntenRechtsKonstante : constant KartenDatentypen.Karten_Grund_Enum := KartenDatentypen.Unterirdische_Flusskurve_Unten_Rechts;
   UnterirdischeFlusskurveUntenLinksKonstante : constant KartenDatentypen.Karten_Grund_Enum := KartenDatentypen.Unterirdische_Flusskurve_Unten_Links;
   UnterirdischeFlusskurveObenRechtsKonstante : constant KartenDatentypen.Karten_Grund_Enum := KartenDatentypen.Unterirdische_Flusskurve_Oben_Rechts;
   UnterirdischeFlusskurveObenLinksKonstante : constant KartenDatentypen.Karten_Grund_Enum := KartenDatentypen.Unterirdische_Flusskurve_Oben_Links;
   UnterirdischeFlusskreuzungDreiObenKonstante : constant KartenDatentypen.Karten_Grund_Enum := KartenDatentypen.Unterirdische_Flusskreuzung_Drei_Oben;
   UnterirdischeFlusskreuzungDreiUntenKonstante : constant KartenDatentypen.Karten_Grund_Enum := KartenDatentypen.Unterirdische_Flusskreuzung_Drei_Unten;
   UnterirdischeFlusskreuzungDreiRechtsKonstante : constant KartenDatentypen.Karten_Grund_Enum := KartenDatentypen.Unterirdische_Flusskreuzung_Drei_Rechts;
   UnterirdischeFlusskreuzungDreiLinksKonstante : constant KartenDatentypen.Karten_Grund_Enum := KartenDatentypen.Unterirdische_Flusskreuzung_Drei_Links;
   UnterirdischesFlussendstückLinksKonstante : constant KartenDatentypen.Karten_Grund_Enum := KartenDatentypen.Unterirdisches_Flussendstück_Links;
   UnterirdischesFlussendstückRechtsKonstante : constant KartenDatentypen.Karten_Grund_Enum := KartenDatentypen.Unterirdisches_Flussendstück_Rechts;
   UnterirdischesFlussendstückUntenKonstante : constant KartenDatentypen.Karten_Grund_Enum := KartenDatentypen.Unterirdisches_Flussendstück_Unten;
   UnterirdischesFlussendstückObenKonstante : constant KartenDatentypen.Karten_Grund_Enum := KartenDatentypen.Unterirdisches_Flussendstück_Oben;
   UnterirdischerSeeKonstante : constant KartenDatentypen.Karten_Grund_Enum := KartenDatentypen.Unterirdischer_See;
                              
   -- Lavafluss
   LavaflusskreuzungVierKonstante : constant KartenDatentypen.Karten_Grund_Enum := KartenDatentypen.Lavaflusskreuzung_Vier;
   LavaflussWaagrechtKonstante : constant KartenDatentypen.Karten_Grund_Enum := KartenDatentypen.Lavafluss_Waagrecht;
   LavaflussSenkrechtKonstante : constant KartenDatentypen.Karten_Grund_Enum := KartenDatentypen.Lavafluss_Senkrecht;
   LavaflusskurveUntenRechtsKonstante : constant KartenDatentypen.Karten_Grund_Enum := KartenDatentypen.Lavaflusskurve_Unten_Rechts;
   LavaflusskurveUntenLinksKonstante : constant KartenDatentypen.Karten_Grund_Enum := KartenDatentypen.Lavaflusskurve_Unten_Links;
   LavaflusskurveObenRechtsKonstante : constant KartenDatentypen.Karten_Grund_Enum := KartenDatentypen.Lavaflusskurve_Oben_Rechts;
   LavaflusskurveObenLinksKonstante : constant KartenDatentypen.Karten_Grund_Enum := KartenDatentypen.Lavaflusskurve_Oben_Links;
   LavaflusskreuzungDreiObenKonstante : constant KartenDatentypen.Karten_Grund_Enum := KartenDatentypen.Lavaflusskreuzung_Drei_Oben;
   LavaflusskreuzungDreiUntenKonstante : constant KartenDatentypen.Karten_Grund_Enum := KartenDatentypen.Lavaflusskreuzung_Drei_Unten;
   LavaflusskreuzungDreiRechtsKonstante : constant KartenDatentypen.Karten_Grund_Enum := KartenDatentypen.Lavaflusskreuzung_Drei_Rechts;
   LavaflusskreuzungDreiLinksKonstante : constant KartenDatentypen.Karten_Grund_Enum := KartenDatentypen.Lavaflusskreuzung_Drei_Links;
   LavaflussendstückLinksKonstante : constant KartenDatentypen.Karten_Grund_Enum := KartenDatentypen.Lavaflussendstück_Links;
   LavaflussendstückRechtsKonstante : constant KartenDatentypen.Karten_Grund_Enum := KartenDatentypen.Lavaflussendstück_Rechts;
   LavaflussendstückUntenKonstante : constant KartenDatentypen.Karten_Grund_Enum := KartenDatentypen.Lavaflussendstück_Unten;
   LavaflussendstückObenKonstante : constant KartenDatentypen.Karten_Grund_Enum := KartenDatentypen.Lavaflussendstück_Oben;
   LavaseeKonstante : constant KartenDatentypen.Karten_Grund_Enum := KartenDatentypen.Lavasee;

end KartenGrundKonstanten;
