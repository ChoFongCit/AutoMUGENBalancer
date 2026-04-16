from pathlib import Path
from dataclasses import dataclass, field


# ---------------------------------------------------------------------------
# Block — unit of genetic material
# ---------------------------------------------------------------------------
@dataclass
class CMD_Block:
    """
    One [State -1] block split into four parts.
    Only `triggers` is modified by genetic operations.

        header    — the [State -1, ...] line
        preamble  — type=, value=, triggerall=, ignorehitpause=, etc.
        triggers  — numbered trigger1/2/3... lines  <- the gene
        trailer   — trailing blank / comment lines
    """
    header:   str
    preamble: list[str]
    triggers: list[str]
    trailer:  list[str]

    def to_lines(self) -> list[str]:
        return [self.header] + self.preamble + self.triggers + self.trailer

    def clone(self):
        return CMD_Block(
            header   = self.header,
            preamble = list(self.preamble),
            triggers = list(self.triggers),
            trailer  = list(self.trailer),
        )
        
        
def assemble_cmd(segments: list, blocks: list[CMD_Block]) -> list[str]:
    """Reconstruct file lines from segments with current block contents."""
    block_iter = iter(blocks)
    output: list[str] = []
    for seg in segments:
        if seg[0] == "pre":
            output.extend(seg[1])
        else:
            output.extend(next(block_iter).to_lines())
    return output


def _resync_segments(segments: list, blocks: list[CMD_Block]) -> list:
    """Rebuild segment list so ('block', ...) entries point to the new blocks."""
    block_iter   = iter(blocks)
    new_segments = []
    for seg in segments:
        if seg[0] == "pre":
            new_segments.append(seg)
        else:
            new_segments.append(("block", next(block_iter)))
    return new_segments
# ---------------------------------------------------------------------------
# Individual - unit of GA population
# ---------------------------------------------------------------------------
@dataclass
class Individual:
    
    def_path: Path
    cmd_path: Path
    elo_rating: int
    name: str
    segments:   list       = field(default_factory=list) 
    blocks:     list       = field(default_factory=list)  
    
    
    def write_cmd(self, path: Path) -> None:
        path.write_text(
            "".join(assemble_cmd(self.segments, self.blocks)),
            encoding="utf-8",
        )
        self.cmd_path = path

    def clone(self, name: str) -> "Individual":
        new_blocks   = [b.clone() for b in self.blocks]
        new_segments = _resync_segments(self.segments, new_blocks)
        return Individual(
        name       = name,
        def_path   = self.def_path,
        cmd_path   = self.cmd_path,
        elo_rating = self.elo_rating,
        segments   = new_segments,
        blocks     = new_blocks,
    )

